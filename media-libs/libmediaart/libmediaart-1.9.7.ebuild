# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
VALA_USE_DEPEND="vapigen"
inherit gnome3 meson vala

DESCRIPTION="Manages, extracts and handles media art caches"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libmediaart"
SRC_URI="https://download.gnome.org/sources/libmediaart/1.9/libmediaart-1.9.7.tar.xz -> libmediaart-1.9.7.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="2"
KEYWORDS="*"
IUSE="gtk-doc +introspection -qt5 vala"
REQUIRED_USE="vala? ( introspection )
"
BDEPEND="dev-libs/gobject-introspection-common
	virtual/pkgconfig
	gtk-doc? ( dev-util/gtk-doc )
	vala? ( $(vala_depend) )
	
"
RDEPEND="dev-libs/glib:2
	!qt5? ( x11-libs/gdk-pixbuf:2 )
	introspection? ( dev-libs/gobject-introspection:= )
	qt5? ( dev-qt/qtgui:5 )
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	use vala && vala_src_prepare
	default
}
src_configure() {
	local image_library
	if use qt5 ; then
	  image_library=qt5
	else
	  image_library=gdk-pixbuf
	fi
	local emesonargs=(
	  -Dimage_library=${image_library}
	  -Dtests=false
	  $(meson_use introspection)
	  $(meson_use vala vapi)
	  $(meson_use gtk-doc gtk_doc)
	)
	meson_src_configure
}


# vim: filetype=ebuild
