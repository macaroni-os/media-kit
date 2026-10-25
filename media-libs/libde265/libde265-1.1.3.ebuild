# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="Open h.265 video codec implementation"
HOMEPAGE="https://github.com/strukturag/libde265"
SRC_URI="https://api.github.com/repos/strukturag/libde265/tarball/v1.1.3 -> libde265-1.1.3-ba62bf4.tar.gz"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="+dec265 sdl debug"
BDEPEND="dec265? ( virtual/pkgconfig )
	
"
RDEPEND="sdl? ( media-libs/libsdl2 )
	
"
DEPEND="${RDEPEND}
	
"

post_src_unpack() {
	mv strukturag-libde265-* ${S}
}


src_configure() {
	  local mycmakeargs=(
	      -DDE265_LOG_LEVEL=$(usex debug debug error)
	      -DENABLE_DECODER=$(usex dec265 ON OFF)
	      -DENABLE_SDL=$(usex sdl ON OFF)
	      -DENABLE_SHERLOCK265=OFF
	  )
	   cmake_src_configure
}



# vim: filetype=ebuild
