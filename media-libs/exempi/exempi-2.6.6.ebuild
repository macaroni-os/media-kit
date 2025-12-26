# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic

DESCRIPTION="Port of the Adobe XMP SDK to work on UNIX"
HOMEPAGE="https://libopenraw.freedesktop.org/wiki/Exempi"
SRC_URI="https://libopenraw.freedesktop.org/download/exempi-2.6.6.tar.xz -> exempi-2.6.6.tar.xz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE="examples"
BDEPEND="sys-devel/autoconf-archive
	sys-devel/gettext
	
"
RDEPEND="dev-libs/expat:=
	sys-libs/zlib
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	# Needed for autoconf 2.71
	config_rpath_update .
	eautoreconf
}
src_configure() {
	# ODR & SA violations
	filter-lto
	append-flags -fno-strict-aliasing
	econf \
	  --enable-static \
	  --disable-unittest \
	  VALGRIND=""
}
src_install() {
	default
	if use examples; then
	  emake -C samples/source distclean
	  rm samples/{,source,testfiles}/Makefile* || die
	  docinto examples
	  dodoc -r samples/.
	fi
	# --disable-static breaks tests
	rm -rf "${ED}/usr/$(get_libdir)/libexempi.a" || die
	find "${ED}" -name '*.la' -delete || die
}


# vim: filetype=ebuild
