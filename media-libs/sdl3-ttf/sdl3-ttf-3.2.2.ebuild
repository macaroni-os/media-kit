# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="Support for TrueType fonts in SDL applications."
HOMEPAGE="https://www.libsdl.org/projects/SDL_ttf/"
SRC_URI="https://api.github.com/repos/libsdl-org/SDL_ttf/tarball/release-3.2.2 -> sdl3-ttf-3.2.2.tar.gz"
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="+harfbuzz static-libs X"
RDEPEND="media-libs/libsdl3
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
	  -DSDL3TTF_VENDORED=OFF
	  -DSDL3TTF_HARFBUZZ=$(usex harfbuzz)
	)
	cmake_src_configure
}



# vim: filetype=ebuild
