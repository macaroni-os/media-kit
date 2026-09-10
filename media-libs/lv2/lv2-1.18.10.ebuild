# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
PYTHON_REQ_USE='threads(+)'
inherit meson python-single-r1

DESCRIPTION="A simple but extensible successor of LADSPA"
HOMEPAGE="https://lv2plug.in/"
SRC_URI="https://lv2plug.in/spec/lv2-1.18.10.tar.xz -> lv2-1.18.10.tar.xz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
DOCS=(
	NEWS
	README.md
)
IUSE="doc plugins"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
BDEPEND="virtual/pkgconfig
	doc? (
	    app-doc/doxygen
	    dev-python/rdflib
	)
	
"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep '
	    dev-python/lxml[${PYTHON_USEDEP}]
	    dev-python/pygments[${PYTHON_USEDEP}]
	    dev-python/rdflib[${PYTHON_USEDEP}]
	')
	
"
DEPEND="${PYTHON_DEPS}
	doc? ( dev-python/markdown )
	plugins? (
	    media-libs/libsamplerate
	    media-libs/libsndfile
	    x11-libs/gtk+:2
	)
	
"
src_prepare() {
	default

	sed -i -e "s:^subdir('test')$:if not get_option('tests').disabled()\n  subdir('test')\nendif:" \
		meson.build || die

	sed -i -e "/codespell = /s:get_option('tests'):false:" test/meson.build || die

	sed -i -e "/serdi = /s:find_program(.*):disabler():" test/meson.build || die

	sed -i -e "s%^lv2_docdir = .*%lv2_docdir = '${EPREFIX}/usr/share/doc/${PF}'%" \
		meson.build || die
}

src_configure() {
	local emesonargs=(
		-Dlv2dir="${EPREFIX}"/usr/$(get_libdir)/lv2
		-Dstrict=false
		$(meson_feature doc docs)
		$(meson_feature plugins)
		-Dtests=disabled
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	if use doc; then
		python_fix_shebang "${ED}"/usr/bin/lv2specgen.py
	fi
}


# vim: filetype=ebuild
