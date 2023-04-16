# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools bash-completion-r1

DESCRIPTION="Screen capture utility using imlib2 library"
HOMEPAGE="https://github.com/resurrecting-open-source-projects/scrot"
SRC_URI="https://github.com/resurrecting-open-source-projects/scrot/tarball/5ef8a82612a57ebd8b70cc45eaea437cbcfed741 -> scrot-1.9-5ef8a82.tar.gz"
#"https://github.com/resurrecting-open-source-projects/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="feh LGPL-2+"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	dev-libs/libbsd
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXfixes
	|| (
		media-libs/imlib2[gif]
		media-libs/imlib2[jpeg]
		media-libs/imlib2[png]
		media-libs/imlib2[tiff]
	)
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
	elibc_musl? ( sys-libs/queue-standalone )
"
BDEPEND="
	sys-devel/autoconf-archive
	virtual/pkgconfig
"

DOCS=(
	AUTHORS ChangeLog README.md
)

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv resurrecting-open-source-projects-scrot* "${S}" || die
	fi
}

src_prepare() {
	default
	# Respect the --docdir option
	sed -e 's/docs_DATA/doc_DATA/g' \
		-e '/docsdir/d' -i Makefile.am || die
	eautoreconf
}

src_install() {
	default
	newbashcomp "${FILESDIR}"/${PN}-1.7.bash-completion ${PN}
}