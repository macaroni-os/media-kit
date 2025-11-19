# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Ugly plugins for GStreamer"
HOMEPAGE="https://gstreamer.freedesktop.org/"
SRC_URI="https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-1.26.8.tar.xz -> gst-plugins-ugly-1.26.8.tar.xz"
LICENSE="LGPL-2+"
SLOT="1.0"
KEYWORDS="*"
IUSE="+x264 cdio dvdread a52dec mpeg2dec sidplay +orc +gpl"
BDEPEND="virtual/perl-JSON-PP
	virtual/pkgconfig
	sys-apps/sed
	
"
RDEPEND=">=media-libs/gst-plugins-base-1.26.8:1.0
	orc? ( dev-lang/orc )
	x264? ( media-libs/x264:= )
	dvdread? ( media-libs/libdvdread:= )
	a52dec? ( media-libs/a52dec:= )
	cdio? ( dev-libs/libcdio:= )
	mpeg2dec? ( media-libs/libmpeg2:= )
	sidplay? ( media-libs/libsidplay:= )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Da52dec=enabled
	  -Dcdio=enabled
	  -Ddvdread=enabled
	  -Dmpeg2dec=enabled
	  -Dx264=enabled
	  -Dsidplay=enabled
	  $(meson_feature x264)
	  $(meson_feature gpl)
	  $(meson_feature dvdread)
	  $(meson_feature a52dec)
	  $(meson_feature cdio)
	  $(meson_feature mpeg2dec)
	  $(meson_feature sidplay)
	  -Dpackage-name="GStreamer ugly plug-ins (MacaroniOS Linux)"
	  -Dpackage-origin="https://macaronios.org"
	)
	meson_src_configure
}


# vim: filetype=ebuild
