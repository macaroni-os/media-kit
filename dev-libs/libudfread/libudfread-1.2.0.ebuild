# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Library for reading UDF from raw devices and image files"
HOMEPAGE="https://code.videolan.org/videolan/libudfread/"
SRC_URI="https://download.videolan.org/pub/videolan/libudfread/libudfread-1.2.0.tar.xz -> libudfread-1.2.0.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="static-libs"
src_configure() {
	local emesonargs=(
	  $(meson_use static-libs embed_udfread)
	)
	meson_src_configure
}


# vim: filetype=ebuild
