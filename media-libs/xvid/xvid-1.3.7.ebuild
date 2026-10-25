# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit flag-o-matic autotools

DESCRIPTION="High performance/quality MPEG-4 video de-/encoding solution"
HOMEPAGE="https://www.xvid.org/"
SRC_URI="https://downloads.xvid.com/downloads/xvidcore-1.3.7.tar.bz2 -> xvidcore-1.3.7.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="examples pic +threads"
DEPEND="sys-apps/grep
	amd64? ( || ( >=dev-lang/yasm-1 >=dev-lang/nasm-2 ) )
	x86? ( || ( >=dev-lang/yasm-1 >=dev-lang/nasm-2 ) )
	x86-macos? ( >=dev-lang/nasm-2 )
	x64-macos? ( >=dev-lang/nasm-2 )
	
"
S="${WORKDIR}/xvidcore/build/generic"
src_prepare() {
	# >=sys-devel/gcc-15 defaults to C23, where bool is a keyword, but
	# xvidcore does typedef int bool in src/encoder.h. Pin C17 until
	# upstream fixes it.
	# https://github.com/macaroni-os/mark-issues/issues/834
	append-flags -std=gnu17
	default

	# make build verbose
	sed \
		-e 's/@$(CC)/$(CC)/' \
		-e 's/@$(AS)/$(AS)/' \
		-e 's/@$(RM)/$(RM)/' \
		-e 's/@$(INSTALL)/$(INSTALL)/' \
		-e 's/@cd/cd/' \
		-i Makefile || die
}

src_configure() {
	use sparc && append-cflags -mno-vis #357149

	local myconf=( $(use_enable threads pthread) )
	#421841
	if use pic ; then
		myconf+=( --disable-assembly )
	fi

	econf "${myconf[@]}"
}

src_install() {
	default

	dodoc "${S}"/../../{AUTHORS,ChangeLog*,CodingStyle,README,TODO}

	if use examples; then
		insinto /usr/share/${PN}
		doins -r "${S}"/../../examples
	fi
}


# vim: filetype=ebuild
