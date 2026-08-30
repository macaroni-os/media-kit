# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="Open-source implementation of JPEG2000 Part-15 (or JPH or HTJ2K)"
HOMEPAGE="https://github.com/aous72/OpenJPH"
SRC_URI="https://api.github.com/repos/aous72/OpenJPH/tarball/0.31.0 -> openjph-0.31.0-c68064d.tar.gz"
LICENSE="BSD-2-Clause"
SLOT="0"
KEYWORDS="*"
DOCS=(
	README.md
)
IUSE="+tiff"
RDEPEND="tiff? ( media-libs/tiff:0= )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv aous72-OpenJPH-* ${S}
}


src_configure() {
	local mycmakeargs=(
	  -DBUILD_SHARED_LIBS=ON
	  -DOJPH_BUILD_EXECUTABLES=ON
	  -DOJPH_ENABLE_TIFF_SUPPORT=$(usex tiff)
	  -DOJPH_BUILD_TESTS=OFF
	  -DOJPH_BUILD_FUZZER=OFF
	  -DOJPH_BUILD_STREAM_EXPAND=OFF
	)
	cmake_src_configure
}



# vim: filetype=ebuild
