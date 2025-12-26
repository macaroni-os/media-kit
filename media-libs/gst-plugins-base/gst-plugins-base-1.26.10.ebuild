# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit flag-o-matic meson

DESCRIPTION="Basepack of plugins for gstreamer"
HOMEPAGE="https://gstreamer.freedesktop.org/"
SRC_URI="https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-1.26.10.tar.xz -> gst-plugins-base-1.26.10.tar.xz"
LICENSE="GPL-2+ LGPL-2+"
SLOT="1.0"
KEYWORDS="*"
IUSE="alsa +egl gbm gles2 +introspection +ogg +opus +opengl
+orc +pango theora +vorbis wayland +X
"
REQUIRED_USE="theora? ( ogg )
vorbis? ( ogg )
opengl? (
  || ( egl X ) || ( gbm wayland X )
  wayland? ( egl )
  gbm? ( egl )
)
"
BDEPEND="virtual/perl-JSON-PP
	virtual/pkgconfig
	sys-apps/sed
	
"
RDEPEND="app-text/iso-codes
	dev-libs/glib:2
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	introspection? ( dev-libs/gobject-introspection:= )
	ogg? ( media-libs/libogg )
	orc? ( dev-lang/orc )
	pango? ( x11-libs/pango )
	theora? ( media-libs/libtheora )
	vorbis? ( media-libs/libvorbis )
	opus? ( media-libs/opus )
	X? (
	  x11-libs/libX11
	  x11-libs/libXext
	  x11-libs/libXv
	)
	gles2? (
	  media-libs/mesa[egl(+)?,gbm(+)?,gles2?,wayland?]
	  egl? (
	    x11-libs/libdrm
	  )
	  gbm? (
	    dev-libs/libgudev
	    x11-libs/libdrm
	  )
	  wayland? (
	    dev-libs/wayland
	    dev-libs/wayland-protocols
	  )
	  media-libs/graphene
	  media-libs/libpng:0
	  virtual/jpeg
	)
	opengl? (
	  media-libs/mesa[egl(+)?,gbm(+)?,gles2?,wayland?]
	  egl? (
	    x11-libs/libdrm
	  )
	  gbm? (
	    dev-libs/libgudev
	    x11-libs/libdrm
	  )
	  wayland? (
	    dev-libs/wayland
	    dev-libs/wayland-protocols
	  )
	  media-libs/graphene
	  media-libs/libpng:0
	  virtual/jpeg
	)
	
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	X? ( x11-base/xorg-proto )
	
"
src_configure() {
	filter-flags -mno-sse -mno-sse2 -mno-sse4.1 #610340
	local emesonargs=(
	  -Dtests=disabled
	  -Dtools=enabled
	  -Ddrm=enabled
	  -Dpackage-name="GStreamer base plug-ins (MacaroniOS Linux)"
	  -Dpackage-origin="https://macaronios.org"
	  -Dalsa=enabled
	  -Dgl=enabled
	  -Dogg=enabled
	  -Dopus=enabled
	  -Dpango=enabled
	  -Dtheora=enabled
	  -Dvorbis=enabled
	  -Dx11=enabled
	  -Dxshm=enabled
	  -Dxvideo=enabled
	  $(meson_feature alsa)
	  $(meson_feature ogg)
	  $(meson_feature opus)
	  $(meson_feature pango)
	  $(meson_feature theora)
	  $(meson_feature vorbis)
	  $(meson_feature X x11)
	  $(meson_feature X xshm)
	  $(meson_feature X xvideo)
	)
	if use opengl || use gles2; then
	  # because meson doesn't like extraneous commas
	  local gl_api=( $(use opengl && echo opengl) $(use gles2 && echo gles2) )
	  local gl_platform=( $(use X && use opengl && echo glx) $(use egl && echo egl) )
	  local gl_winsys=(
	    $(use X && echo x11)
	    $(use wayland && echo wayland)
	    $(use egl && echo egl)
	    $(use gbm && echo gbm)
	  )
	  emesonargs+=(
	    -Dgl=enabled
	    -Dgl-graphene=enabled
	    -Dgl_api=$(IFS=, ; echo "${gl_api[*]}")
	    -Dgl_platform=$(IFS=, ; echo "${gl_platform[*]}")
	    -Dgl_winsys=$(IFS=, ; echo "${gl_winsys[*]}")
	  )
	else
	  emesonargs+=(
	    -Dgl=disabled
	    -Dgl_api=
	    -Dgl_platform=
	    -Dgl_winsys=
	  )
	fi
	# Workaround EGL/eglplatform.h being built with X11 present
	use X || export CFLAGS="${CFLAGS} -DEGL_NO_X11"
	meson_src_configure
}


# vim: filetype=ebuild
