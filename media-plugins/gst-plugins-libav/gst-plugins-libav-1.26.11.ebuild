# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="FFmpeg based gstreamer plugin"
HOMEPAGE="https://gstreamer.freedesktop.org/modules/gst-libav.html"
SRC_URI="https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-1.26.11.tar.xz -> gst-libav-1.26.11.tar.xz"
LICENSE="LGPL-2+"
SLOT="1.0"
KEYWORDS="*"
BDEPEND="virtual/perl-JSON-PP
	virtual/pkgconfig
	sys-apps/sed
	
"
RDEPEND="dev-libs/glib:2
	>=media-libs/gstreamer-1.26.11:1.0
	media-libs/gst-plugins-base:1.0
	media-video/ffmpeg:=
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/gst-libav-1.26.11"
src_configure() {
	local emesonargs=(
	  -Dpackage-name="GStreamer libav plug-ins (MacaroniOS Linux)"
	  -Dpackage-origin="https://macaronios.org"
	)
	meson_src_configure
}


# vim: filetype=ebuild
