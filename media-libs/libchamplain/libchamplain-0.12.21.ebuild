# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
VALA_USE_DEPEND="vapigen"
inherit gnome3 meson vala

DESCRIPTION="Clutter based world map renderer"
HOMEPAGE="https://wiki.gnome.org/Projects/libchamplain"
SRC_URI="https://download.gnome.org/sources/libchamplain/0.12/libchamplain-0.12.21.tar.xz -> libchamplain-0.12.21.tar.xz"
LICENSE="LGPL-2"
SLOT="0.12"
KEYWORDS="*"
IUSE="doc +gtk +introspection +vala"
REQUIRED_USE="vala? ( introspection )
"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="dev-db/sqlite:3
	dev-libs/glib:2
	media-libs/clutter:1.0[introspection?]
	media-libs/cogl:=
	net-libs/libsoup:3
	x11-libs/cairo
	x11-libs/gtk+:3
	gtk? (
	  x11-libs/gtk+:3[introspection?]
	  media-libs/clutter-gtk:1.0
	)
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc-am )
	vala? ( $(vala_depend) )
	
"
src_prepare() {
	eapply_user
	use vala && vala_src_prepare
	gnome3_src_prepare
}
src_configure() {
	local emesonargs=(
	  -Dmemphis=false
	  -Ddemos=false
	  $(meson_use introspection)
	  $(meson_use doc gtk_doc)
	  $(meson_use gtk widgetry)
	  $(meson_use vala vapi)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
}


# vim: filetype=ebuild
