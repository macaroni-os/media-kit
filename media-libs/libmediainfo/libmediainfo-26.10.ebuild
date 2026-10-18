# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools edos2unix flag-o-matic

DESCRIPTION="MediaInfo libraries"
HOMEPAGE="https://mediaarea.net/en/MediaInfo https://github.com/MediaArea/MediaInfoLib"
SRC_URI="https://mediaarea.net/download/source/libmediainfo/26.10/libmediainfo_26.10.tar.xz -> libmediainfo_26.10.tar.xz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="*"
IUSE="curl doc mms"
BDEPEND="virtual/pkgconfig
	doc? ( app-doc/doxygen )
	
"
RDEPEND="dev-libs/tinyxml2:=
	>=media-libs/libzen-0.4.41
	sys-libs/zlib:=
	curl? ( net-misc/curl )
	mms? ( >=media-libs/libmms-0.6.1 )
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/MediaInfoLib"
src_prepare() {
	default
	cd Project/GNU/Library || die
	sed -i 's:-O2::' configure.ac || die
	append-cppflags -DMEDIAINFO_LIBMMS_DESCRIBE_SUPPORT=0
	eautoreconf
}

src_configure() {
	cd Project/GNU/Library || die
	econf \
		--enable-shared \
		--disable-static \
		--disable-staticlibs \
		--with-libtinyxml2 \
		$(use_with curl libcurl) \
		$(use_with mms libmms)
}

src_compile() {
	cd Project/GNU/Library || die
	default
	if use doc; then
		cd "${WORKDIR}"/MediaInfoLib/Source/Doc || die
		doxygen Doxyfile || die
	fi
}

src_install() {
	if use doc; then
		local HTML_DOCS=( "${WORKDIR}"/MediaInfoLib/Doc/*.html )
	fi

	cd Project/GNU/Library || die
	default

	edos2unix libmediainfo.pc
	insinto /usr/$(get_libdir)/pkgconfig
	doins libmediainfo.pc

	local x
	for x in ./ Archive Audio Duplicate Export Image Multiple Reader Tag Text Video; do
		insinto /usr/include/MediaInfo/${x}
		doins "${S}"/Source/MediaInfo/${x}/*.h
	done

	insinto /usr/include/MediaInfoDLL
	doins "${S}"/Source/MediaInfoDLL/*.h

	dodoc "${S}"/*.txt

	find "${ED}" -name '*.la' -delete || die
}


# vim: filetype=ebuild
