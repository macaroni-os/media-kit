# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit gnome3 meson

DESCRIPTION="CD ripper for GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/SoundJuicer"
SRC_URI="https://download.gnome.org/sources/sound-juicer/3.40/sound-juicer-3.40.0.tar.xz -> sound-juicer-3.40.0.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
IUSE="flac vorbis"
BDEPEND="app-text/iso-codes
	app-text/docbook-xml-dtd:4.3
	dev-libs/appstream-glib
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2[dbus]
	x11-libs/gtk+:3
	gnome-base/gsettings-desktop-schemas
	app-cdr/brasero
	media-plugins/gst-plugins-meta:1.0[cdda,flac?]
	gnome-base/gvfs[cdda,udev]
	media-libs/libcanberra
	media-libs/musicbrainz:=
	media-libs/libdiscid
	sys-apps/dbus
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	# Avoid sandbox failures
	sed -i -e '/gst_inspect/d' meson.build || die
	default
}
src_install() {
	meson_src_install
	# Don't put files in deprecated directory
	rm -rf "${ED}"/usr/share/doc/${PN} || die
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
