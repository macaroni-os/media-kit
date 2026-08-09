# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit toolchain-funcs

DESCRIPTION="An easy-to-use hash implementation for C programmers"
HOMEPAGE="https://troydhanson.github.io/uthash/index.html"
SRC_URI="https://api.github.com/repos/troydhanson/uthash/tarball/refs/tags/v2.4.0 -> uthash-2.4.0-a49bed0.tar.gz"
LICENSE="BSD-1"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
	mv troydhanson-uthash-* ${S}
}


src_configure() {
	tc-export CC
}

src_install() {
	doheader src/*.h
	dodoc doc/*.txt
}



# vim: filetype=ebuild
