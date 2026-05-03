# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="Image decoding for many popular formats for SDL."
HOMEPAGE="https://www.libsdl.org/projects/SDL_image/"
SRC_URI="https://api.github.com/repos/libsdl-org/SDL_image/tarball/release-2.8.12 -> sdl2-image-2.8.12-12cb2e4.tar.gz"
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="gif jpeg png static-libs tiff webp"
RDEPEND="media-libs/libsdl2
	sys-libs/zlib
	png? ( media-libs/libpng )
	jpeg? ( virtual/jpeg )
	tiff? ( media-libs/tiff )
	webp? ( media-libs/libwebp )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv libsdl-org-SDL_image-* ${S}
}


src_configure() {
	local mycmakeargs=(
	  -DSDL2IMAGE_AVIF=OFF
	  -DSDL2IMAGE_BMP=ON
	  -DSDL2IMAGE_GIF=$(usex gif)
	  -DSDL2IMAGE_JPG=$(usex jpeg)
	  -DSDL2IMAGE_JXL=OFF
	  -DSDL2IMAGE_LBM=ON
	  -DSDL2IMAGE_PCX=ON
	  -DSDL2IMAGE_PNG=$(usex png)
	  -DSDL2IMAGE_PNM=ON
	  -DSDL2IMAGE_QOI=ON
	  -DSDL2IMAGE_SVG=ON
	  -DSDL2IMAGE_TGA=ON
	  -DSDL2IMAGE_TIF=$(usex tiff)
	  -DSDL2IMAGE_WEBP=$(usex webp)
	  -DSDL2IMAGE_XCF=ON
	  -DSDL2IMAGE_XPM=ON
	  -DSDL2IMAGE_XV=ON
	  -DSDL2IMAGE_BACKEND_STB=OFF
	  -DSDL2IMAGE_DEPS_SHARED=OFF
	  -DSDL2IMAGE_SAMPLES_INSTALL=ON
	  -DSDL2IMAGE_TESTS=OFF
	  -DSDL2IMAGE_TESTS_INSTALL=OFF
	  -DSDL2IMAGE_VENDORED=OFF
	)
	cmake_src_configure
}



# vim: filetype=ebuild
