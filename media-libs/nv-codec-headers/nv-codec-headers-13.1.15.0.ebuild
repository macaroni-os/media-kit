# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit multilib

DESCRIPTION="FFmpeg version of headers required to interface with NVIDIA codec APIs"
HOMEPAGE="https://github.com/FFmpeg/nv-codec-headers"
SRC_URI="https://api.github.com/repos/FFmpeg/nv-codec-headers/tarball/n13.1.15.0 -> nv-codec-headers-13.1.15.0-0a6fba9.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
	mv FFmpeg-nv-codec-headers-* ${S}
}


src_compile() {
	emake PREFIX="${EPREFIX}/usr" LIBDIR="$(get_libdir)"
}

src_install() {
	emake \
	  PREFIX="${EPREFIX}/usr" \
	  LIBDIR="$(get_libdir)" \
	  DESTDIR="${D}" \
	  install
	 einstalldocs
}



# vim: filetype=ebuild
