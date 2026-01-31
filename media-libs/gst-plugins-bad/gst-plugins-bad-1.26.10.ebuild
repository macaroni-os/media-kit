# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Less plugins for GStreamer"
HOMEPAGE="https://gstreamer.freedesktop.org/"
SRC_URI="https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-1.26.10.tar.xz -> gst-plugins-bad-1.26.10.tar.xz"
LICENSE="LGPL-2+"
SLOT="1.0"
KEYWORDS="*"
IUSE="X bzip2 +egl gles2 +introspection +opengl +orc opus udev vaapi
vnc wayland aac dts dvb dvd mpeg2enc libass modplug mplex x265
"
BDEPEND="virtual/perl-JSON-PP
	virtual/pkgconfig
	sys-apps/sed
	
"
RDEPEND=">=media-libs/gstreamer-1.26.10:1.0[introspection?]
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
	  x11-libs/libva
	  udev? ( dev-libs/libgudev )
	)
	aac? (
	  media-libs/faad2
	)
	dts? (
	  media-libs/libdca
	  orc? ( dev-lang/orc )
	)
	dvd? (
	  media-libs/libdvdnav
	  media-libs/libdvdread
	)
	mpeg2enc? (
	  media-video/mjpegtools
	)
	libass? (
	  media-libs/libass:=
	)
	opus? (
	  media-libs/opus:=
	)
	modplug? (
	  media-libs/libmodplug
	)
	mplex? (
	  media-video/mjpegtools
	)
	x265? (
	  media-libs/x265
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
	  -Dassrender=enabled
	  -Ddts=enabled
	  -Ddvb=enabled
	  -Dfaad=enabled
	  -Dfaac=enabled
	  -Dbz2=enabled
	  -Dhls=enabled
	  -Dipcpipeline=enabled
	  -Dassrender=enabled
	  -Dx265=enabled
	  -Dlibrfb=enabled
	  -Dmodplug=enabled
	  -Dmpeg2enc=enabled
	  -Dmplex=enabled
	  -Dopus=enabled
	  -Dresindvd=enabled
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
	  $(meson_feature aac faad)
	  $(meson_feature aac faac)
	  $(meson_feature dvd resindvd)
	  $(meson_feature mpeg2enc)
	  $(meson_feature libass assrender)
	  $(meson_feature opus)
	  $(meson_feature mplex)
	  $(meson_feature dts)
	  $(meson_feature x265)
	  $(meson_feature modplug)
	  -Dpackage-name="GStreamer bad plug-ins (MacaroniOS Linux)"
	  -Dpackage-origin="https://macaronios.org"
	)
	if use opengl || use gles2 ; then
	  emesonargs+=( -Dgl=enabled )
	else
	  emesonargs+=( -Dgl=disabled )
	fi
	if use aac || use dts || use dvd || use mpeg2enc || use mplex || use faad ; then
	  emesonargs+=( -Dgpl=enabled )
	else
	  emesonargs+=( -Dgpl=disabled )
	fi
	meson_src_configure
}


# vim: filetype=ebuild
