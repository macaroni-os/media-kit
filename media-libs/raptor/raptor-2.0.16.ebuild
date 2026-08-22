# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools toolchain-funcs

DESCRIPTION="The RDF Parser Toolkit"
HOMEPAGE="https://librdf.org/raptor/"
SRC_URI="https://download.librdf.org/source/raptor2-2.0.16.tar.gz -> raptor2-2.0.16.tar.gz"
LICENSE="Apache-2.0 GPL-2 LGPL-2.1"
SLOT="2"
KEYWORDS="*"
DOCS=(
	AUTHORS
	ChangeLog
	NEWS
	NOTICE
	README
)
IUSE="+curl debug json static-libs"
BDEPEND="sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/libxml2
	dev-libs/libxslt
	curl? ( net-misc/curl )
	json? ( dev-libs/yajl )
	!media-libs/raptor:0
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/raptor2-2.0.16"
src_prepare() {
	default
	eautoreconf
	elibtoolize # Keep this for ~*-fbsd
	# Fix compatibility with libxml2 - macaroni-os/mark-issues#420
	sed -e '/ret->checked/d'  -i src/raptor_libxml.c || die
}
src_configure() {
	tc-export PKG_CONFIG
	local myeconfargs=(
		--with-html-dir="${EPREFIX}"/usr/share/gtk-doc/html
		$(usex curl --with-www=curl --with-www=xml)
		$(use_enable debug)
		$(use_with json yajl)
		$(use_enable static-libs static)
	)
	econf "${myeconfargs[@]}"
}
src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}


# vim: filetype=ebuild
