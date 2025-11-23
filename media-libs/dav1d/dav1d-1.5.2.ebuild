# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson ninja-utils

DESCRIPTION="dav1d is an AV1 Decoder :)"
HOMEPAGE="https://code.videolan.org/videolan/dav1d"
SRC_URI="https://download.videolan.org/pub/videolan/dav1d/1.5.2/dav1d-1.5.2.tar.xz -> dav1d-1.5.2.tar.xz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="*"
DOCS=(
	README.md
	doc/PATENTS
	THANKS.md
)
IUSE="+8bit +10bit +asm xxhash"
BDEPEND="asm? (
	    dev-lang/nasm
	)
	
"
RDEPEND="xxhash? (
	  dev-libs/xxhash
	)
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local -a bits=()
	use 8bit  && bits+=( 8 )
	use 10bit && bits+=( 16 )
	 local emesonargs=(
	  -Dbitdepths=$(IFS=,; echo "${bits[*]}")
	  -Denable_tests=false
	  -Denable_asm=$(usex asm true false)
	  $(meson_feature xxhash xxhash_muxer)
	)
	meson_src_configure
}


# vim: filetype=ebuild
