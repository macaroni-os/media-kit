# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit autotools flag-o-matic java-pkg-opt-2 python-single-r1 qmake-utils

DESCRIPTION=""
SRC_URI="https://gitlab.com/graphviz/graphviz/-/archive/14.1.4/graphviz-14.1.4.tar.bz2 -> graphviz-14.1.4.tar.bz2"
SLOT="0"
KEYWORDS="*"
IUSE="+cairo devil doc examples gdk-pixbuf gtk gts guile java lasi nls pdf perl postscript python qt5 qt6 ruby static-libs svg tcl X"
RDEPEND=">=dev-libs/expat-2
	>=dev-libs/glib-2.11.1:2
	dev-libs/libltdl:0
	>=media-libs/fontconfig-2.3.95
	>=media-libs/freetype-2.1.10
	>=media-libs/gd-2.0.34:=[fontconfig,jpeg,png,truetype,zlib]
	>=media-libs/libpng-1.2:0=
	sys-libs/zlib
	virtual/jpeg:0
	virtual/libiconv
	cairo? (
	    x11-libs/cairo
	    >=x11-libs/pango-1.12
	)
	devil? ( media-libs/devil[png,jpeg] )
	gtk? ( x11-libs/gtk+:2 )
	gts? ( sci-libs/gts )
	lasi? ( media-libs/lasi )
	pdf? ( app-text/poppler )
	perl? ( dev-lang/perl:= )
	postscript? ( app-text/ghostscript-gpl )
	python? ( ${PYTHON_DEPS} )
	qt5? (
	    dev-qt/qtcore:5
	    dev-qt/qtgui:5
	    dev-qt/qtprintsupport:5
	    dev-qt/qtwidgets:5
	)
	ruby? ( dev-lang/ruby:* )
	tcl? ( >=dev-lang/tcl-8.3:0= )
	X? (
	    x11-libs/libX11
	    x11-libs/libXaw
	    x11-libs/libXmu
	    x11-libs/libXpm
	    x11-libs/libXt
	)
	
"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/libtool
	virtual/pkgconfig
	guile? ( dev-lang/swig dev-scheme/guile )
	java? ( dev-lang/swig >=virtual/jdk-1.5 )
	nls? ( >=sys-devel/gettext-0.14.5 )
	perl? ( dev-lang/swig )
	python? ( dev-lang/swig )
	ruby? ( dev-lang/swig )
	tcl? ( dev-lang/swig )
	
"
pkg_setup() {
	use guile && guile-single_pkg_setup
	use python && python-single-r1_pkg_setup
}
src_prepare() {
	./autogen.sh
	default
	eautoreconf
}
src_configure() {
	# Force detect of the qmake binary
	# without using qtchooser
	# Note if both qt5 and qt6 are enabled
	# qt6 wins
	if use qt5 ; then
	  export PATH=$PATH:/usr/lib64/qt5/bin/
	fi
	if use qt6 ; then
	  export PATH=$PATH:/usr/lib64/qt6/bin/
	fi
	 local myconf=(
	  # Speeds up the libltdl configure
	  --cache-file="${S}"/config.cache
	  --enable-ltdl
	  $(use_with cairo pangocairo)
	  $(use_with devil)
	  $(use_enable gdk-pixbuf)
	  $(use_with gtk)
	  $(use_with gts)
	  $(use_with lasi)
	  $(use_with pdf poppler)
	  $(use_with postscript ghostscript)
	  $(use_enable static-libs static)
	  $(use_with X x)
	  $(use_with X xaw)
	  $(use_with X lefty)
	  --with-digcola
	  --with-fontconfig
	  --with-freetype2
	  --with-ipsepcola
	  --with-libgd
	  --with-sfdp
	  --without-ming
	  --without-rsvg
	  # new/experimental features, to be tested, disable for now
	  --with-cgraph
	  --without-glitz
	  --without-ipsepcola
	  --without-smyrna
	  --without-visio
	  # Bindings:
	  $(use_enable guile)
	  $(use_enable java)
	  $(use_enable perl)
	  $(use_enable python python3)
	  $(use_enable ruby)
	  $(use_with svg rsvg)
	  $(use_enable tcl)
	  --disable-go
	  --disable-io
	  --disable-lua
	  --disable-ocaml
	  --disable-php
	  --disable-python
	  --disable-r
	  --disable-sharp
	  # libtool file collision, bug #276609
	  --without-included-ltdl
	  --disable-ltdl-install
	)
	 if use qt6 || use qt5 ; then
	  myconf+=(
	    --with-qt
	  )
	fi
	econf "${myconf[@]}"
}
src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
	use guile && guile_unstrip_ccache
	use python && python_optimize \
	    "${D}"$(python_get_sitedir) \
	    "${ED}"/usr/$(get_libdir)/graphviz/python3
}
pkg_postinst() {
	# We need to register all plugins before they become usable
	dot -c || die
}
pkg_postrm() {
	# Remove cruft, bug #547344
	rm -rf "${EROOT}"/usr/$(get_libdir)/graphviz/config{,6} || die
}


# vim: filetype=ebuild
