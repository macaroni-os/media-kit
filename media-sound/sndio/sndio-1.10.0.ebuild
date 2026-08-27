# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools toolchain-funcs user

DESCRIPTION="Small audio and MIDI framework part of the OpenBSD project"
HOMEPAGE="https://sndio.org/"
SRC_URI="https://sndio.org/sndio-1.10.0.tar.gz -> sndio-1.10.0.tar.gz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="*"
IUSE="alsa"
RDEPEND="dev-libs/libbsd
	alsa? ( media-libs/alsa-lib )
	
"
DEPEND="${RDEPEND}
"
pkg_setup(){
	enewuser sndiod -1 -1 -1 audio
}
src_configure() {
	tc-export CC
	./configure \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--privsep-user=sndiod \
		--with-libbsd \
		$(use_enable alsa) \
	|| die "Configure failed"
}
src_install() {
	default
	doinitd "${FILESDIR}/sndiod"
}


# vim: filetype=ebuild
