# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Good plugins for GStreamer"
HOMEPAGE="https://gstreamer.freedesktop.org/"
SRC_URI="https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-1.26.8.tar.xz -> gst-plugins-good-1.26.8.tar.xz"
LICENSE="LGPL-2+"
SLOT="1.0"
KEYWORDS="*"
IUSE="+orc"
BDEPEND="virtual/perl-JSON-PP
	virtual/pkgconfig
	sys-apps/sed
	
"
RDEPEND=">=media-libs/gst-plugins-base-1.26.8:1.0
	app-arch/bzip2
	sys-libs/zlib
	orc? ( dev-lang/orc )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Dbz2=enabled
	  -Dpackage-name="GStreamer good plug-ins (MacaroniOS Linux)"
	  -Dpackage-origin="https://macaronios.org"
	)
	meson_src_configure
}


# vim: filetype=ebuild
