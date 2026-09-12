# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="A large collection of free and portable video plugins"
HOMEPAGE="https://dyne.org/frei0r/"
SRC_URI="https://api.github.com/repos/dyne/frei0r/tarball/v3.5.0 -> frei0r-plugins-3.5.0-0e664fd.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
DOCS=(
	AUTHORS.md
	BUILD.md
	README.md
)
IUSE="+cairo facedetect +scale0tilt"
BDEPEND="virtual/pkgconfig
"
RDEPEND="cairo? ( x11-libs/cairo )
	facedetect? ( >=media-libs/opencv-4:= )
	scale0tilt? ( >=media-libs/gavl-1.2.0 )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv dyne-frei0r-* ${S}
}


src_prepare() {
	cmake_src_prepare
	sed -i \
	  -e '/set *(CMAKE_SHARED_LINKER_FLAGS/s:":"${CMAKE_SHARED_LINKER_FLAGS} :' \
	  src/CMakeLists.txt || die
}
src_configure() {
	local mycmakeargs=(
	  -DBUILD_TESTING=OFF
	  -DFREI0R_VERSION="${PV}"
	  -DWITHOUT_CAIRO=$(usex !cairo)
	  -DWITHOUT_OPENCV=$(usex !facedetect)
	  -DWITHOUT_GAVL=$(usex !scale0tilt)
	  -DWITHOUT_FACERECOGNITION=$(usex !facedetect)
	)
	cmake_src_configure
}



# vim: filetype=ebuild
