# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 meson python-any-r1

DESCRIPTION="A simple, modern sound recorder for GNOME"
SRC_URI="https://download.gnome.org/sources/gnome-sound-recorder/42/gnome-sound-recorder-42.0.tar.xz -> gnome-sound-recorder-42.0.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
BDEPEND="${PYTHON_DEPS}
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/gjs
	dev-libs/glib:2
	x11-libs/gtk:4[introspection]
	media-plugins/gst-plugins-meta[flac,pulseaudio]
	x11-libs/libadwaita:=
	x11-libs/gdk-pixbuf:2[introspection]
	dev-libs/gobject-introspection
	
"
DEPEND="${RDEPEND}
"
pkg_setup() {
	python-any-r1_pkg_setup
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
