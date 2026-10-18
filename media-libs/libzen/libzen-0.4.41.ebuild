# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools

DESCRIPTION="Shared library for libmediainfo and mediainfo"
HOMEPAGE="https://github.com/MediaArea/ZenLib"
SRC_URI="https://mediaarea.net/download/source/libzen/0.4.41/libzen_0.4.41.tar.xz -> libzen_0.4.41.tar.xz"
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="doc static-libs"
BDEPEND="virtual/pkgconfig
	doc? ( app-doc/doxygen )
	
"
S="${WORKDIR}/ZenLib/Project/GNU/Library"
src_prepare() {
	default
	sed -i 's:-O2::' configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		--enable-unicode \
		--enable-shared \
		$(use_enable static-libs static)
}

src_compile() {
	default
	if use doc ; then
		cd "${WORKDIR}"/ZenLib/Source/Doc || die
		doxygen Doxyfile || die
	fi
}

src_install() {
	default

	rm -f "${ED}"/usr/bin/libzen-config || die

	insinto /usr/$(get_libdir)/pkgconfig
	doins libzen.pc

	local x
	for x in ./ Format/Html Format/Http HTTP_Client ; do
		insinto /usr/include/ZenLib/${x}
		doins "${WORKDIR}"/ZenLib/Source/ZenLib/${x}/*.h
	done

	dodoc "${WORKDIR}"/ZenLib/History.txt
	if use doc ; then
		docinto html
		dodoc "${WORKDIR}"/ZenLib/Doc/*
	fi

	find "${ED}" -name '*.la' -delete || die
}


# vim: filetype=ebuild
