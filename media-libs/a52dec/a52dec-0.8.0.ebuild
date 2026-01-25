# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="Library for decoding ATSC A/52 streams (AKA 'AC-3')"
HOMEPAGE="https://git.adelielinux.org/community/a52dec/"
SRC_URI="https://distfiles.adelielinux.org/source/a52dec/a52dec-0.8.0.tar.gz -> a52dec-0.8.0.tar.gz"
LICENSE="GPL-2.0-or-later"
SLOT="0"
KEYWORDS="*"
IUSE="djbfft"
RDEPEND="djbfft? ( sci-libs/djbfft )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	sed -i -e '/^CFLAGS = @CFLAGS@ @LIBA52_CFLAGS@/d' liba52/Makefile.am || die
	sed -i -e '/^LIBA52_CFLAGS="$LIBA52_CFLAGS -prefer-non-pic"/d' liba52/configure.incl || die
	sed -i -e '/^CFLAGS = @A52DEC_CFLAGS@/d' src/Makefile.am || die
	eautoreconf
	filter-flags -fprefetch-loop-arrays
}
src_configure() {
	ECONF_SOURCE="${S}" econf \
	  --disable-static \
	  --enable-shared \
	  $(use_enable djbfft) \
	  --disable-oss
}
src_compile() {
	emake CFLAGS="${CFLAGS}"
}
src_install() {
	default
	einstalldocs
	dodoc HISTORY doc/liba52.txt
	find "${ED}" -name '*.la' -type f -delete || die
}


# vim: filetype=ebuild
