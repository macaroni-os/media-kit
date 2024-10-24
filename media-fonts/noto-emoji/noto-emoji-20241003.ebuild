# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3+ )

inherit font python-any-r1

DESCRIPTION="Google Noto Emoji fonts"
HOMEPAGE="https://www.google.com/get/noto/ https://github.com/googlefonts/noto-emoji"

SRC_URI="https://github.com/googlefonts/noto-emoji/tarball/22e564626297b4df0a40570ad81d6c05cc7c38bd -> noto-emoji-20241003-22e564626297b4df0a40570ad81d6c05cc7c38bd.tar.gz"

LICENSE="Apache-2.0 OFL-1.1"
SLOT="0"
KEYWORDS="*"
IUSE="buildfont"

BDEPEND="
	buildfont? (
		${PYTHON_DEPS}
		app-arch/zopfli
		$(python_gen_any_dep '
			dev-python/fonttools[${PYTHON_USEDEP}]
			dev-python/nototools[${PYTHON_USEDEP}]
		')
		media-gfx/pngquant
		x11-libs/cairo
		|| ( media-gfx/imagemagick[png] media-gfx/graphicsmagick[png] )
	)
"

RESTRICT="binchecks strip"

python_check_deps() {
	has_version -b "dev-python/fonttools[${PYTHON_USEDEP}]" &&
	has_version -b "dev-python/nototools[${PYTHON_USEDEP}]"
}

pkg_setup() {
	font_pkg_setup
}

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv ${WORKDIR}/googlefonts-noto-emoji-* ${S} || die
	fi
}

src_prepare() {
	default

	# Drop font for Windows 10
	rm fonts/NotoColorEmoji_WindowsCompatible.ttf || die

	if use buildfont; then
		sed -i 's/FLAGS = \$(SELECTED_FLAGS)/FLAGS = \$(ALL_FLAGS)/g' Makefile
	fi
}

src_compile() {
	if ! use buildfont; then
		einfo "Installing pre-built fonts provided by upstream."
		einfo "They could be not fully updated or miss some items."
		einfo "To build fonts based on latest images enable 'buildfont'"
		einfo "USE (that will require more time and resources too)."
	else
		python_setup
		einfo "Building fonts..."

		# From Debian:
		# The build requires a VIRTUAL_ENV variable and sequence check isn't working
		VIRTUAL_ENV=true \
		BYPASS_SEQUENCE_CHECK=true \
		default
	fi
}

src_install() {
	if ! use buildfont; then
		FONT_S="${S}/fonts"
	else
		mv -i fonts/NotoEmoji-Regular.ttf "${S}" || die
		# Built font and Regular font
		FONT_S="${S}"

		# Don't lose fancy emoji icons
		for i in 32 72 128 512; do
			insinto "/usr/share/icons/${PN}/${i}/emotes/"
			doins png/"${i}"/*.png
		done

		insinto /usr/share/icons/"${PN}"/scalable/emotes/
		doins svg/*.svg
	fi

	FONT_SUFFIX="ttf"
	font_src_install

	dodoc README.md
}