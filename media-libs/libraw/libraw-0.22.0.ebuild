# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit flag-o-matic libtool autotools toolchain-funcs

DESCRIPTION="LibRaw is a library for reading RAW files from digital cameras"
HOMEPAGE="www.libraw.org"
SRC_URI="https://api.github.com/repos/LibRaw/LibRaw/tarball/refs/tags/0.22.0 -> libraw-0.22.0-0b56545.tar.gz"
LICENSE="NOASSERTION"
SLOT="0"
KEYWORDS="*"
DOCS=(
	Changelog.txt
	README.md
)
IUSE="examples hardened jpeg +lcms openmp zlib"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="jpeg? ( media-libs/libjpeg-turbo:= )
	lcms? ( media-libs/lcms )
	zlib? ( sys-libs/zlib )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv LibRaw-LibRaw-* ${S}
}


src_prepare() {
	default
	elibtoolize
	eautoreconf
	if tc-is-clang && use openmp ; then
	  append-libs omp
	fi
}
src_configure() {
	# added in 0.21.3 if selected calloc() will be used to prevent uninitialized heap data leak
	use hardened && append-cppflags "-DLIBRAW_CALLOC_RAWSTORE"
	local myeconfargs=(
	  --disable-jasper
	  $(use_enable examples)
	  $(use_enable jpeg)
	  $(use_enable lcms)
	  $(use_enable openmp)
	  $(use_enable zlib)
	)
	econf "${myeconfargs[@]}"
}
src_install() {
	default
	einstalldocs
	# package installs .pc files
	find "${D}" -name '*.la' -name '*.a' -delete || die
}



# vim: filetype=ebuild
