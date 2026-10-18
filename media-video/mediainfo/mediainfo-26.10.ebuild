# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
WX_GTK_VER="3.0-gtk3"
inherit autotools wxwidgets xdg-utils

DESCRIPTION="MediaInfo supplies technical and tag information about media files"
HOMEPAGE="https://mediaarea.net/en/mediainfo/ https://github.com/MediaArea/MediaInfo"
SRC_URI="https://mediaarea.net/download/source/mediainfo/26.10/mediainfo_26.10.tar.xz -> mediainfo_26.10.tar.xz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="*"
IUSE="curl mms wxwidgets"
BDEPEND="virtual/pkgconfig
"
RDEPEND="~media-libs/libmediainfo-${PV}[curl=,mms=]
	>=media-libs/libzen-0.4.41
	sys-libs/zlib:=
	wxwidgets? ( x11-libs/wxGTK:${WX_GTK_VER}=[X] )
	
"
DEPEND="${RDEPEND}
	wxwidgets? ( app-eselect/eselect-wxwidgets )
	
"
S="${WORKDIR}/MediaInfo"
pkg_setup() {
	TARGETS="CLI"
	if use wxwidgets; then
		TARGETS+=" GUI"
		setup-wxwidgets
	fi
}

src_prepare() {
	default
	local target
	for target in ${TARGETS}; do
		cd "${S}"/Project/GNU/${target} || die
		sed -i -e "s:-O2::" configure.ac || die
		eautoreconf
	done
}

src_configure() {
	local target args
	for target in ${TARGETS}; do
		cd "${S}"/Project/GNU/${target} || die
		args=""
		[[ ${target} == "GUI" ]] && args="--with-wxwidgets --with-wx-gui"
		econf ${args}
	done
}

src_compile() {
	local target
	for target in ${TARGETS}; do
		cd "${S}"/Project/GNU/${target} || die
		default
	done
}

src_install() {
	local target
	for target in ${TARGETS}; do
		cd "${S}"/Project/GNU/${target} || die
		default
		dodoc "${S}"/History_${target}.txt
	done
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}


# vim: filetype=ebuild
