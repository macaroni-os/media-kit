# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools

DESCRIPTION="Library parsing the Corel cdr documents"
HOMEPAGE="https://wiki.documentfoundation.org/DLP/Libraries/libcdr"
SRC_URI="https://dev-www.libreoffice.org/src/libcdr/libcdr-0.1.8.tar.xz -> libcdr-0.1.8.tar.xz"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="doc"
BDEPEND="sys-devel/libtool
	virtual/pkgconfig
	doc? ( app-text/doxygen )
	
"
RDEPEND="dev-libs/icu:=
	dev-libs/librevenge
	media-libs/lcms
	sys-libs/zlib
	
"
DEPEND="${RDEPEND}
	dev-libs/boost
	
"
src_prepare() {
	  default
	  elibtoolize
}
src_configure() {
	  local myeconfargs=(
	      $(use_with doc docs)
	      --disable-tests
	  )
	  econf "${myeconfargs[@]}"
}
src_install() {
	  default
	  find "${D}" -name '*.la' -delete || die
}


# vim: filetype=ebuild
