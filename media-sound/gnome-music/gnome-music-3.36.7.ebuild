# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit gnome3 python-single-r1 meson

DESCRIPTION="Music management for Gnome"
HOMEPAGE="https://wiki.gnome.org/Apps/Music"
SRC_URI="https://download.gnome.org/sources/gnome-music/3.36/gnome-music-3.36.7.tar.xz -> gnome-music-3.36.7.tar.xz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/gnome-music-meson36.patch"
)
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
# Commons depends
CDEPEND="${PYTHON_DEPS}
	>=net-libs/gnome-online-accounts-${PV%.*}
	app-misc/tracker:=
	$(python_gen_cond_dep '>=dev-python/pygobject-3.21.1:3[cairo,${PYTHON_USEDEP}]')
	dev-libs/glib:2
	dev-libs/gobject-introspection:=
	media-libs/grilo:0.3[introspection]
	media-libs/libmediaart:2.0[introspection]
	x11-libs/gtk+:3[introspection]
	dev-libs/libdazzle
	
"
RDEPEND="${COMMON_DEPEND}
	x11-libs/libnotify[introspection]
	$(python_gen_cond_dep 'dev-python/dbus-python[${PYTHON_USEDEP}]
	  dev-python/requests[${PYTHON_USEDEP}]')
	media-libs/gstreamer:1.0[introspection]
	media-libs/gst-plugins-base:1.0[introspection]
	media-plugins/gst-plugins-meta:1.0
	media-plugins/grilo-plugins:0.3[tracker]
	x11-misc/xdg-user-dirs
	
"
DEPEND="${COMMON_DEPEND}
	app-text/yelp-tools
	dev-util/intltool
	virtual/pkgconfig
	
"
pkg_setup() {
	python_setup
}
src_prepare() {
	sed -e '/sys.path.insert/d' -i "${S}"/gnome-music.in || die "python fixup sed failed"
	gnome3_src_prepare
}
src_install() {
	meson_src_install
	python_fix_shebang "${D}"/usr/bin/gnome-music
}


# vim: filetype=ebuild
