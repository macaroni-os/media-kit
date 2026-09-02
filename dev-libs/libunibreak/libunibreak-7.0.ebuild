# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="The libunibreak library"
HOMEPAGE="https://github.com/adah1972/libunibreak http://vimgadgets.sourceforge.net/libunibreak/"
SRC_URI="https://github.com/adah1972/libunibreak/releases/download/libunibreak_7_0/libunibreak-7.0.tar.gz -> libunibreak-7.0.tar.gz"
LICENSE="Zlib"
SLOT="0"
KEYWORDS="*"
IUSE="doc +man static-libs"
BDEPEND="doc? ( app-doc/doxygen )
	man? ( app-doc/doxygen )
	
"
src_prepare() {
	default

	if use man || use doc; then
		echo "GENERATE_MAN=$(usex man YES NO)" >> Doxyfile || die
		echo "GENERATE_HTML=$(usex doc YES NO)" >> Doxyfile || die
	fi
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_compile() {
	default

	if use man || use doc; then
		doxygen || die "doxygen failed"
	fi

	if use man; then
		cd doc/man || die
		mv man3 x || die
		mkdir man3 || die
		local h
		for h in unibreakbase unibreakdef linebreak linebreakdef \
			eastasianwidthdef graphemebreak wordbreak; do
			mv x/${h}.h.3 man3/ || die "man page for ${h}.h not found"
		done
		rm -r x || die
		cd "${S}" || die
	fi
}

src_install() {
	use doc && local HTML_DOCS=( doc/html/. )

	default

	use man && doman doc/man/man3/*.3

	find "${ED}" -name '*.la' -delete || die
}


# vim: filetype=ebuild
