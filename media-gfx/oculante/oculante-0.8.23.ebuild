# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="A fast and simple image viewer / editor for many operating systems"
HOMEPAGE="https://github.com/woelper/oculante"
SRC_URI="https://github.com/woelper/oculante/tarball/899fa9d2abdd4717fe2c4e3255432cbb78713f08 -> oculante-0.8.23-899fa9d.tar.gz
https://distfiles.macaronios.org/eb/4d/e6/eb4de6052a4f01171e4eb562b6b7242edf18e9f8bcc16e1d40ac5fcac03df95a0030db81ad3847ccc4dac6d01a13c6577473d2d3b395b4be2cddc2c0e07412c2 -> oculante-0.8.23-funtoo-crates-bundle-de6b318effd32563dbb6288a7a6bba3e4343a0fb90683cd7bf06c2e2e68789aafb503743f002ebc26bf981864f6806a5dbbdf7cca66653300952c92bf15e283e.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

ASM_DEP=">=dev-lang/nasm-2.15"
DEPEND="
	app-arch/bzip2
	app-arch/brotli
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib
	dev-libs/libffi
	media-libs/freetype
	media-libs/fontconfig
	media-libs/harfbuzz
	media-libs/libglvnd
	media-libs/libpng
	media-gfx/graphite2
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gtk+
	x11-libs/pango
	x11-libs/libxcb
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcursor
	x11-libs/libXdmcp
	x11-libs/libXfixes
"
RDEPEND="${DEPEND}"
BDEPEND="
	amd64? ( ${ASM_DEP} )
	dev-util/cmake
	virtual/rust
"

DOCS=( README.md CHANGELOG.md )

QA_FLAGS_IGNORED="/usr/bin/oculante"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/woelper-oculante-* ${S} || die
}

src_install() {
	cargo_src_install
	einstalldocs
}