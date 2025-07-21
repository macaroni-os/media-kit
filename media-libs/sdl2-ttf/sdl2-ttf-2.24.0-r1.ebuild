# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="Support for TrueType fonts in SDL applications."
HOMEPAGE="https://www.libsdl.org/projects/SDL_ttf/"
SRC_URI="https://api.github.com/repos/libsdl-org/SDL_ttf/tarball/release-2.24.0 -> sdl2-ttf-2.24.0.tar.gz"
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="+harfbuzz static-libs X"
RDEPEND="media-libs/libsdl2
	media-libs/freetype[harfbuzz?]
	virtual/opengl
	harfbuzz? ( media-libs/harfbuzz )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv libsdl-org-SDL_ttf-* ${S}
}


src_configure() {
	local mycmakeargs=(
	  -DSDL2TTF_VENDORED=OFF
	  -DSDL2TTF_HARFBUZZ=$(usex harfbuzz)
	)
	cmake_src_configure
}



# vim: filetype=ebuild
