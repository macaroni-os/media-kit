# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools flag-o-matic toolchain-funcs

DESCRIPTION="Tools for generating DVD files to be played on standalone DVD players"
HOMEPAGE="http://dvdauthor.sourceforge.net/"
SRC_URI="https://api.github.com/repos/ldo/dvdauthor/tarball/refs/tags/0.7.2 -> dvdauthor-0.7.2-e0e0d41.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/dvdauthor-freetype_pkgconfig.patch"
	"${FILESDIR}/dvdauthor-0.7.2-libxml2-pkgconfig.patch"
	"${FILESDIR}/dvdauthor-0.7.2-release-manpages.patch"
)
DOCS=(
	AUTHORS
	ChangeLog
	README
	TODO
)
IUSE="graphicsmagick +imagemagick"
REQUIRED_USE="^^ ( graphicsmagick imagemagick )"
BDEPEND="sys-devel/bison
	sys-devel/flex
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND=">=dev-libs/fribidi-0.19.2
	dev-libs/libxml2
	>=media-libs/freetype-2
	media-libs/libdvdread
	media-libs/libpng:0=
	graphicsmagick? ( media-gfx/graphicsmagick:= )
	imagemagick? ( media-gfx/imagemagick:= )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv ldo-dvdauthor-* ${S}
}


src_prepare() {
	default
	 # The release tarballs shipped autotools/config.rpath for the
	# AM_ICONV macro; the git tree does not, so take the copy
	# installed by sys-devel/gettext (mark-issues#764).
	mkdir -p autotools || die
	cp "${ESYSROOT}/usr/share/gettext/config.rpath" autotools/config.rpath || die
	 eautoreconf
	 if use imagemagick && has_version '>=media-gfx/imagemagick-7.0.1.0' ; then
	  eapply "${FILESDIR}/${PN}-0.7.2-imagemagick7.patch"
	fi
	 if use graphicsmagick ; then
	  sed -i -e 's:ExportImagePixels:dIsAbLeAuToMaGiC&:' configure || die
	fi
}
src_configure() {
	use graphicsmagick && \
	  append-cppflags "$($(tc-getPKG_CONFIG) --cflags GraphicsMagick)"
	append-cppflags "$($(tc-getPKG_CONFIG) --cflags fribidi)"
	econf
}



# vim: filetype=ebuild
