# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Cross-platform ncurses Spotify client written in Rust, inspired by ncmpc and the likes."
HOMEPAGE="https://github.com/hrkfdn/ncspot"
SRC_URI="https://github.com/hrkfdn/ncspot/tarball/7ce6e532fca311883bc855b43a83b8e8a7b9e616 -> ncspot-1.1.2-7ce6e53.tar.gz
https://distfiles.macaronios.org/3c/c9/2c/3cc92c127740890c6f658df940f745fc267db3a8c4097a60e9afa2095a570838c13bfaf7e6bc08bc7963b558c72acc2b1097b2320439f0fc56e756a544012e3c -> ncspot-1.1.2-funtoo-crates-bundle-dbfe11dcf358a640da377515fc30f5ae06d96d76d57457300c801754338fd1f1f8ef70ec79a47eb54fce7389ca01f5a6fe3a4e53af2ddfead49cb3ebe3449df5.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND=""
BDEPEND="virtual/rust"

DOCS=( README.md CHANGELOG.md )

QA_FLAGS_IGNORED="/usr/bin/ncspot"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/hrkfdn-ncspot-* ${S} || die
}