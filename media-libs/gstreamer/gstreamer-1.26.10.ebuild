# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Open source multimedia framework"
HOMEPAGE="https://gstreamer.freedesktop.org/"
SRC_URI="https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-1.26.10.tar.xz -> gstreamer-1.26.10.tar.xz"
LICENSE="LGPL-2+"
SLOT="1.0"
KEYWORDS="*"
DOCS=(
	ChangeLog
	NEWS
	MAINTAINERS
	README.md
	RELEASE
)
IUSE="+caps +introspection ptp unwind"
BDEPEND="virtual/rust
	virtual/yacc
	sys-devel/flex
	dev-util/gtk-doc-am
	
"
RDEPEND="dev-libs/glib:2
	caps? ( sys-libs/libcap )
	introspection? ( dev-libs/gobject-introspection:= )
	unwind? (
	  sys-libs/libunwind
	  dev-libs/elfutils
	)
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Dbenchmarks=disabled
	  -Dexamples=disabled
	  -Dcheck=enabled
	  -Dtests=disabled
	  -Dpackage-name="GStreamer (MacaroniOS Linux)"
	  -Dpackage-origin="https://macaronios.org"
	  $(meson_feature introspection)
	  $(meson_feature unwind libunwind)
	  $(meson_feature unwind libdw)
	)
	 if use caps ; then
	  emesonargs+=( -Dptp-helper-permissions=capabilities )
	else
	  emesonargs+=(
	    -Dptp-helper-permissions=setuid-root
	    -Dptp-helper-setuid-user=nobody
	    -Dptp-helper-setuid-group=nobody
	  )
	fi
	meson_src_configure
}
src_install() {
	meson_src_install
	find "${ED}" -name '*.la' -delete || die
}


# vim: filetype=ebuild
