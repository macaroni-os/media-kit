# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Cross-platform ncurses Spotify client written in Rust, inspired by ncmpc and the likes."
HOMEPAGE="https://github.com/hrkfdn/ncspot"
SRC_URI="https://github.com/hrkfdn/ncspot/tarball/189298b256f42db33c17a8b2cb1da87ad8225ea1 -> ncspot-1.2.1-189298b.tar.gz
https://distfiles.macaronios.org/ff/fc/e7/fffce716f4669b53dd15e68cfb176281e170939d43249f1d0007ca50274b12444a3fef742c3a249f87c212d5d2ee16c852ae8809b8f23fc98795a82141f9c223 -> ncspot-1.2.1-funtoo-crates-bundle-fcf4d90aef4a9c18096c101a785ed9b1b5ffd29887f0b0a05c1bcf2d172576eaf797c40f85563d46516f493b96f53df84e5e339d24a883b8a172a71f14171b65.tar.gz"

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