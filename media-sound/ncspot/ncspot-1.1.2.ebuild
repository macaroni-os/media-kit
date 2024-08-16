# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Cross-platform ncurses Spotify client written in Rust, inspired by ncmpc and the likes."
HOMEPAGE="https://github.com/hrkfdn/ncspot"
SRC_URI="https://github.com/hrkfdn/ncspot/tarball/7ce6e532fca311883bc855b43a83b8e8a7b9e616 -> ncspot-1.1.2-7ce6e53.tar.gz
https://distfiles.macaronios.org/c2/10/75/c2107566f1c96e7f2fce9ba3b39cbf453e65c6feeb988113c4033c54b695a91340648b964870d2df975e596496d4c5d98930f4737176e88d62c6b9921f273daa -> ncspot-1.1.2-funtoo-crates-bundle-dbfe11dcf358a640da377515fc30f5ae06d96d76d57457300c801754338fd1f1f8ef70ec79a47eb54fce7389ca01f5a6fe3a4e53af2ddfead49cb3ebe3449df5.tar.gz"

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