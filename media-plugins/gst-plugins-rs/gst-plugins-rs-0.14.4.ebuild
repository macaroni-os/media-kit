# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
ECARGO_BUNDLE_POSTFIX="mark-rust-bundle"
inherit cargo meson

DESCRIPTION="GStreamer plugins written in Rust"
HOMEPAGE="https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs"
SRC_URI="
https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/archive/0.14.4/gst-plugins-rs-0.14.4.tar.bz2 -> gst-plugins-rs-0.14.4.tar.bz2
mirror://macaroni/gst-plugins-rs-0.14.4-mark-rust-bundle.tar.xz -> gst-plugins-rs-0.14.4-mark-rust-bundle.tar.xz"
SLOT="1.0"
KEYWORDS="*"
IUSE="+dav1d"
RDEPEND="dev-libs/glib
	x11-libs/gtk:4
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/freetype
	dav1d? (
	  media-libs/dav1d
	)
	
"
DEPEND="${RDEPEND}
"
src_prepare() {
	default
	rm -rf tutorial
	sed -i -e '/"tutorial"/d' Cargo.toml
}
src_configure() {
	MAKEOPTS="-j3"
	cargo_src_configure
	local emesonargs=(
	  -Dflavors=disabled
	  -Dtests=disabled
	  -Dexamples=disabled
	  -Ddoc=disabled
	  -Dskia=disabled
	  #-Danalytics=disabled
	)
	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
}


# vim: filetype=ebuild
