# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="Lightweight video thumbnailer that can be used by file managers"
HOMEPAGE="https://github.com/dirkvdb/ffmpegthumbnailer"
SRC_URI="https://api.github.com/repos/dirkvdb/ffmpegthumbnailer/tarball/v2.3.0 -> ffmpegthumbnailer-2.3.0-cfaf0c5.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="gnome gtk jpeg png"
REQUIRED_USE="gnome? ( gtk )
"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="gtk? ( dev-libs/glib:2= )
	jpeg? ( virtual/jpeg:0= )
	png? ( media-libs/libpng:0= )
	media-video/ffmpeg:=
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv dirkvdb-ffmpegthumbnailer-* ${S}
}


src_prepare() {
	rm -rf out* || die
	sed -e 's|^libdir=${exec_prefix}/lib|libdir=${exec_prefix}/@CMAKE_INSTALL_LIBDIR@|g' -i libffmpegthumbnailer.pc.in
	cmake_src_prepare
}
src_configure() {
	local mycmakeargs=(
	  -DENABLE_TESTS=OFF
	  -DENABLE_GIO=$(usex gtk)
	  -DENABLE_THUMBNAILER=$(usex gnome)
	  -DHAVE_JPEG=$(usex jpeg)
	  -DHAVE_PNG=$(usex png)
	)
	cmake_src_configure
}



# vim: filetype=ebuild
