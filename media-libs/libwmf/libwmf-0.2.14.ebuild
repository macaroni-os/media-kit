# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
GHOSTSCRIPT_VERSION="9.53.3"
inherit autotools gnome3

DESCRIPTION=""
HOMEPAGE="https://github.com/caolanm/libwmf"
SRC_URI="https://api.github.com/repos/caolanm/libwmf/tarball/refs/tags/v0.2.14 -> libwmf-0.2.14-33e99d1.tar.gz"
LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/libwmf-0.2.8.4-build.patch"
	"${FILESDIR}/libwmf-0.2.8.4-libpng-1.5.patch"
	"${FILESDIR}/libwmf-0.2.8.4-pngfix.patch"
)
IUSE="debug doc expat X"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="app-text/ghostscript-gpl
	media-fonts/urw-fonts
	media-libs/freetype:=
	media-libs/libpng:=
	media-libs/libjpeg-turbo
	sys-libs/zlib
	x11-libs/gdk-pixbuf:2
	expat? ( dev-libs/expat )
	!expat? ( dev-libs/libxml2:= )
	X? (
	  x11-libs/libX11
	  x11-libs/libXt
	  x11-libs/libXpm
	)
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv caolanm-libwmf-* ${S}
}


src_prepare() {
	default
	eautoreconf
}
src_configure() {
	local myeconfargs=(
	  --disable-gd
	  --disable-static
	  $(use_enable debug)
	  $(use_with expat)
	  $(use_with !expat libxml2)
	  $(use_with X x)
	  --with-docdir=/usr/share/doc/libwmf-0.2.14/
	  --with-fontdir=/usr/share/fonts/urw-fonts
	  --with-freetype
	  --with-gsfontdir=/usr/share/fonts/urw-fonts
	  --with-gsfontmap=/usr/share/ghostscript/${GHOSTSCRIPT_VERSION}/Resource/Init/Fontmap
	  --with-jpeg
	  --with-layers
	  --with-png
	  --with-sys-gd
	  --with-zlib
	)
	econf "${myeconfargs[@]}"
}
src_install() {
	MAKEOPTS=-j1
	default
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}



# vim: filetype=ebuild
