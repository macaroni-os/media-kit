# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="Image decoding for many popular formats for SDL."
HOMEPAGE="https://www.libsdl.org/projects/SDL_image/"
SRC_URI="https://api.github.com/repos/libsdl-org/SDL_image/tarball/release-3.4.0 -> sdl3-image-3.4.0-ad58ecf.tar.gz"
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="gif jpeg png static-libs tiff webp"
RDEPEND="media-libs/libsdl3
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
	  -DSDLIMAGE_DEPS_SHARED=ON
	  -DSDLIMAGE_INSTALL_MAN=ON
	  -DSDLIMAGE_STRICT=ON
	  -DSDLIMAGE_TESTS_INSTALL=OFF
	  -DSDLIMAGE_TESTS=OFF
	  -DSDLIMAGE_VENDORED=OFF
	  -DSDLIMAGE_BACKEND_STB=OFF
	  # TODO: add libavif?
	  -DSDLIMAGE_AVIF=OFF
	  -DSDLIMAGE_AVIF_SAVE=OFF
	  -DSDLIMAGE_BMP=ON
	  -DSDLIMAGE_GIF=$(usex gif)
	  -DSDLIMAGE_JPG=$(usex jpeg)
	  -DSDLIMAGE_JPG_SAVE=$(usex jpeg)
	  # TODO: add jpegxl
	  -DSDLIMAGE_JXL=OFF
	  -DSDLIMAGE_LBM=ON
	  -DSDLIMAGE_PCX=ON
	  -DSDLIMAGE_PNG=$(usex png)
	  -DSDLIMAGE_PNG_SAVE=$(usex png)
	  -DSDLIMAGE_PNM=ON
	  -DSDLIMAGE_QOI=ON
	  -DSDLIMAGE_SVG=ON
	  -DSDLIMAGE_TGA=ON
	  -DSDLIMAGE_TIF=$(usex tiff)
	  -DSDLIMAGE_WEBP=$(usex webp)
	  -DSDLIMAGE_XCF=ON
	  -DSDLIMAGE_XPM=ON
	  -DSDLIMAGE_XV=ON
	)
	cmake_src_configure
}



# vim: filetype=ebuild
