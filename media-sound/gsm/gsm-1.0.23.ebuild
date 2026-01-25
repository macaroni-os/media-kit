# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools

DESCRIPTION="Lossy speech compression library"
HOMEPAGE="https://www.quut.com/gsm/"
SRC_URI="https://www.quut.com/gsm/gsm-1.0.23.tar.gz -> gsm-1.0.23.tar.gz"
LICENSE="TU-Berlin-2.0"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/gsm-1.0.23-makefile.patch"
)
DOCS=(
	ChangeLog
	MACHINES
	MANIFEST
	README
)
post_src_unpack() {
	mv gsm-* "${S}"
}
src_compile() {
	local myemakeargs=(
	  CC="$(tc-getCC)"
	  LD="$(tc-getCC)"
	  AR="$(tc-getAR)"
	  RANLIB="$(tc-getRANLIB)"
	)
	emake -j1 CCFLAGS="${CFLAGS} -c -DNeedFunctionPrototypes=1 -fPIC" "${myemakeargs[@]}"
}
src_install() {
	default
	dodir /usr/bin /usr/$(get_libdir) /usr/include/gsm /usr/share/man/man{1,3}
	local myemakeargs=(
	  CC="$(tc-getCC)"
	  LD="$(tc-getCC)"
	  AR="$(tc-getAR)"
	  RANLIB="$(tc-getRANLIB)"
	  INSTALL_ROOT="${ED}"/usr
	  GSM_INSTALL_LIB="${ED}"/usr/$(get_libdir)
	  GSM_INSTALL_INC="${ED}"/usr/include/gsm
	  GSM_INSTALL_MAN="${ED}"/usr/share/man/man3
	  TOAST_INSTALL_MAN="${ED}"/usr/share/man/man1
	)
	emake -j1 "${myemakeargs[@]}" install
	dosym ../gsm/gsm.h /usr/include/libgsm/gsm.h
}


# vim: filetype=ebuild
