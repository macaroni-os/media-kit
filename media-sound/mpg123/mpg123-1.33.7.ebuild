# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools

DESCRIPTION="a realtime MPEG 1.0/2.0/2.5 audio player for layers 1, 2 and 3"
HOMEPAGE="https://www.mpg123.org/"
SRC_URI="https://www.mpg123.org/download/mpg123-1.33.7.tar.bz2 -> mpg123-1.33.7.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="*"
DOCS=(
	AUTHORS
	ChangeLog
	NEWS
	NEWS.libmpg123
	README
)
IUSE="alsa int-quality ipv6 jack nas oss portaudio pulseaudio sdl"
BDEPEND="virtual/pkgconfig
"
RDEPEND="app-eselect/eselect-mpg123
	dev-libs/libltdl:0
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
	nas? ( media-libs/nas )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	sdl? ( media-libs/libsdl )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local audio=dummy
	local output=dummy

	for flag in nas portaudio sdl oss jack alsa pulseaudio; do
		if use ${flag}; then
			audio+=" ${flag/pulseaudio/pulse}"
			output=${flag/pulseaudio/pulse}
		fi
	done

	econf \
		--with-audio="${audio}" \
		--with-default-audio="${output}" \
		--enable-network \
		$(use_enable ipv6) \
		--enable-int-quality=$(usex int-quality)
}

src_install() {
	default
	# the binary is managed by eselect-mpg123
	mv "${ED%/}"/usr/bin/mpg123{,-mpg123} || die
	find "${ED%/}" -name "*.la" -delete || die
}

pkg_postinst() {
	eselect mpg123 update ifunset
}

pkg_postrm() {
	eselect mpg123 update ifunset
}


# vim: filetype=ebuild
