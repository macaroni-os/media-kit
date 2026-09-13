# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit bash-completion-r1 meson python-single-r1

DESCRIPTION="Library to make the use of LV2 plugins as simple as possible for applications"
HOMEPAGE="https://drobilla.net/software/lilv"
SRC_URI="https://download.drobilla.net/lilv-0.28.0.tar.xz -> lilv-0.28.0.tar.xz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="*"
DOCS=(
	AUTHORS
	NEWS
	README.md
)
IUSE="+dyn-manifest python +tools"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
BDEPEND="virtual/pkgconfig
"
RDEPEND=">=dev-libs/serd-0.30.10
	>=dev-libs/sord-0.16.20
	>=dev-libs/zix-0.6.0
	>=media-libs/lv2-1.18.2
	>=media-libs/sratom-0.6.10
	python? ( ${PYTHON_DEPS} )
	tools? ( >=media-libs/libsndfile-1.0.0 )
	
"
DEPEND="${RDEPEND}
"
pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local emesonargs=(
		-Ddocs=disabled
		-Dhtml=disabled
		-Dsinglehtml=disabled
		-Dlint=false
		$(meson_feature dyn-manifest dynmanifest)
		$(meson_feature python bindings_py)
		$(meson_feature tools)
		-Dbindings_cpp=enabled
		-Dtests=disabled
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	if use tools; then
		rm -r "${ED}"/etc/bash_completion.d || die
		newbashcomp tools/lilv.bash_completion ${PN}
	fi

	newenvd - 60lv2 <<-EOF
		LV2_PATH=${EPREFIX}/usr/$(get_libdir)/lv2
	EOF
}


# vim: filetype=ebuild
