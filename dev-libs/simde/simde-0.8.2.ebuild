# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Header-only library providing implementations of SIMD instruction sets"
HOMEPAGE="https://simd-everywhere.github.io/blog/"
SRC_URI="https://api.github.com/repos/simd-everywhere/simde/tarball/v0.8.2 -> simde-0.8.2-71fd833.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
	mv simd-everywhere-simde-* ${S}
}


src_configure() {
	unset {C,CPP,CXX,LD}FLAGS
	 local emesonargs=(
	  -Dtests=false
	)
	 meson_src_configure
}



# vim: filetype=ebuild
