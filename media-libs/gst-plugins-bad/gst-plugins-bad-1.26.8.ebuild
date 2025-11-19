# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Less plugins for GStreamer"
HOMEPAGE="https://gstreamer.freedesktop.org/"
SRC_URI="https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.26.8.tar.xz -> gst-plugins-bad-1.26.8.tar.xz"
LICENSE="LGPL-2+"
SLOT="1.0"
KEYWORDS="*"
IUSE="X bzip2 +egl gles2 +introspection +opengl +orc udev vaapi vnc wayland"
BDEPEND="virtual/perl-JSON-PP
	virtual/pkgconfig
	sys-apps/sed
	
"
RDEPEND=">=media-libs/gstreamer-1.26.8:1.0[introspection?]
	introspection? ( dev-libs/gobject-introspection )
	bzip2? ( app-arch/bzip2 )
	vnc? ( X? ( x11-libs/libX11 ) )
	wayland? (
	  dev-libs/wayland
	  x11-libs/libdrm
	  dev-libs/wayland-protocols
	)
	orc? ( dev-lang/orc )
	vaapi? (
	  media-libs/libva
	  udev? ( dev-libs/libgudev )
	)
	
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	
"
src_prepare() {
	default
	addpredict /dev # Prevent sandbox violations bug #570624
}
src_configure() {
	local emesonargs=(
	  -Dbz2=enabled
	  -Dhls=enabled
	  -Dipcpipeline=enabled
	  -Dlibrfb=enabled
	  -Dshm=enabled
	  -Dva=enabled
	  -Dwayland=enabled
	  -Dtests=disabled
	  -Dhls=disabled
	  $(meson_feature vnc librfb)
	  $(meson_feature vaapi va)
	  -Dudev=$(usex udev $(usex vaapi enabled disabled) disabled)
	  $(meson_feature vnc librfb)
	  -Dx11=$(usex X $(usex vnc enabled disabled) disabled)
	  $(meson_feature wayland)
	  -Dpackage-name="GStreamer bad plug-ins (MacaroniOS Linux)"
	  -Dpackage-origin="https://macaronios.org"
	)
	if use opengl || use gles2; then
	  myconf+=( -Dgl=enabled )
	else
	  myconf+=( -Dgl=disabled )
	fi
	meson_src_configure
}


# vim: filetype=ebuild
