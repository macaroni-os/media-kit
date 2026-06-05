# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Interpret and import Visio diagrams"
HOMEPAGE="https://wiki.documentfoundation.org/DLP/Libraries/libvisio"
SRC_URI="https://dev-www.libreoffice.org/src/libvisio/libvisio-0.1.11.tar.xz -> libvisio-0.1.11.tar.xz"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="doc tools"
BDEPEND="virtual/pkgconfig
	doc? ( app-doc/doxygen )
	
"
RDEPEND="dev-libs/icu:=
	dev-libs/librevenge
	dev-libs/libxml2:=
	
"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-util/gperf
	sys-devel/libtool
	
"
src_configure() {
	local myeconfargs=(
	  $(use_with doc docs)
	  $(use_enable tools)
	  --disable-tests
	)
	econf "${myeconfargs[@]}"
}
src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}


# vim: filetype=ebuild
