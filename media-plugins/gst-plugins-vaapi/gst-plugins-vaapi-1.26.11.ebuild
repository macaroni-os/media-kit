# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Hardware accelerated video decoding through VA-API plugin for GStreamer"
HOMEPAGE="https://gitlab.freedesktop.org/gstreamer/gstreamer-vaapi"
SRC_URI="https://gstreamer.freedesktop.org/src/gstreamer-vaapi/gstreamer-vaapi-1.26.11.tar.xz -> gstreamer-vaapi-1.26.11.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="1.0"
KEYWORDS="*"
IUSE="+drm +egl gles2 +opengl wayland +X"
REQUIRED_USE="|| ( drm gles2 opengl wayland X )
gles2? ( egl )
opengl? ( || ( egl X ) )
"
BDEPEND="virtual/perl-JSON-PP
	virtual/pkgconfig
	sys-apps/sed
	
"
RDEPEND="dev-libs/glib:2
	>=media-libs/gst-plugins-base-1.26.11:1.0[egl?,gles2?,opengl?,wayland?,X?]
	media-libs/mesa[gles2?,egl(+)?,X?]
	x11-libs/libva:=[drm?,wayland?,X?]
	drm? (
	  virtual/libudev:=
	  x11-libs/libdrm
	)
	wayland? ( dev-libs/wayland )
	X? (
	  x11-libs/libX11
	  x11-libs/libXrandr
	  x11-libs/libXrender
	)
	
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	
"
S="${WORKDIR}/gstreamer-vaapi-1.26.11"
src_configure() {
	local emesonargs=(
	  -Dpackage-origin="https://macaronios.org"
	  $(meson_feature drm)
	  $(meson_feature X x11)
	  $(meson_feature wayland)
	  $(meson_feature wayland egl)
	)
	if use opengl || use gles2; then
	    emesonargs+=( -Dglx=enabled )
	else
	    emesonargs+=( -Dglx=disabled )
	fi
	# Workaround EGL/eglplatform.h being built with X11 present
	use X || export CFLAGS="${CFLAGS} -DEGL_NO_X11"
	meson_src_configure
}


# vim: filetype=ebuild
