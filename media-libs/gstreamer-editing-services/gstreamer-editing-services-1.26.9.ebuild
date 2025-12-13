# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit meson python-r1 bash-completion-r1

DESCRIPTION="SDK for making video editors and more"
HOMEPAGE="http://wiki.pitivi.org/wiki/GES"
SRC_URI="https://gstreamer.freedesktop.org/src/gstreamer-editing-services/gst-editing-services-1.26.9.tar.xz -> gst-editing-services-1.26.9.tar.xz"
LICENSE="LGPL-2+"
SLOT="1.0"
KEYWORDS="*"
IUSE="+introspection bash-completion"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
BDEPEND="virtual/perl-JSON-PP
	virtual/pkgconfig
	sys-apps/sed
	
"
RDEPEND="${PYTHON_DEPS}
	dev-libs/glib:2
	dev-libs/libxml2:2=
	>=media-libs/gstreamer-1.26.9:1.0[introspection?]
	>=media-libs/gst-plugins-base-1.26.9:1.0[introspection?]
	>=media-libs/gst-plugins-bad-1.26.9:1.0[introspection?]
	introspection? ( dev-libs/gobject-introspection:= )
	bash-completion? ( app-shells/bash-completion )
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/gst-editing-services-1.26.9"
src_configure() {
	python_setup
	local emesonargs=(
	  -Ddoc=disabled # hotdoc not packaged
	  -Dtests=disabled
	  -Dxptv=disabled
	  -Dpython=enabled
	  -Dvalidate=disabled
	  -Dexamples=disabled
	  $(meson_feature bash-completion)
	  $(meson_feature introspection)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	python_moduleinto gi.overrides
	python_foreach_impl python_domodule bindings/python/gi/overrides/GES.py
}


# vim: filetype=ebuild
