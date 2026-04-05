# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
LUA_COMPAT=( lua5-{1,3} )
inherit lua-single meson systemd user

DESCRIPTION="Mirror of the PipeWire repository (see https://gitlab.freedesktop.org/pipewire/wireplumber/)"
HOMEPAGE="https://github.com/PipeWire/wireplumber"
SRC_URI="https://api.github.com/repos/PipeWire/wireplumber/tarball/refs/tags/0.5.14 -> wireplumber-0.5.14-07e730b.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
DOCS=(
	NEWS.rst
	README.rst
)
IUSE="elogind systemd"
REQUIRED_USE="${LUA_REQUIRED_USE}
?? ( elogind systemd )
"
BDEPEND="dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${LUA_DEPS}
	dev-libs/glib:2
	media-video/pipewire:=
	virtual/libintl
	elogind? ( sys-auth/elogind )
	systemd? ( sys-apps/systemd )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv PipeWire-wireplumber-* ${S}
}


pkg_setup() {
	lua-single_pkg_setup
	enewgroup pipewire
	enewuser pipewire -1 -1 /var/run/pipewire "pipewire,audio"
}
src_configure() {
	local emesonargs=(
	  -Ddaemon=true
	  -Dtools=true
	  -Dmodules=true
	  -Ddoc=disabled
	  -Dintrospection=disabled # Only used for Sphinx doc generation
	  -Dsystem-lua=true # We always unbundle everything we can
	  -Dsystem-lua-version=$(ver_cut 1-2 $(lua_get_version))
	  $(meson_feature elogind)
	  $(meson_feature systemd)
	  $(meson_use systemd systemd-system-service)
	  $(meson_use systemd systemd-user-service)
	  -Dsystemd-system-unit-dir=$(systemd_get_systemunitdir)
	  -Dsystemd-user-unit-dir=$(systemd_get_userunitdir)
	  -Dtests=false
	  -Ddbus-tests=false
	)
	meson_src_configure
}



# vim: filetype=ebuild
