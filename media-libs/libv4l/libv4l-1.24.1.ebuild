# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools linux-info

MY_P="v4l-utils-${PV}"

DESCRIPTION="Separate libraries ebuild from upstream v4l-utils package"
HOMEPAGE="https://git.linuxtv.org/v4l-utils.git"
SRC_URI="https://linuxtv.org/downloads/v4l-utils/v4l-utils-1.24.1.tar.bz2 -> v4l-utils-1.24.1.tar.bz2"

LICENSE="LGPL-2.1+"
SLOT="0/0"
KEYWORDS="*"
IUSE="dvb jpeg"

RDEPEND="
	virtual/libudev
	!elibc_glibc? ( sys-libs/argp-standalone )
	jpeg? ( >=virtual/jpeg-0-r2:0= )
	!media-tv/v4l2-ctl
	!<media-tv/ivtv-utils-1.4.0-r2
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	CONFIG_CHECK="~SHMEM"
	linux-info_pkg_setup
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	# Hard disable the flags that apply only to the utils.
	ECONF_SOURCE=${S} \
	econf \
		--disable-static \
		$(use_enable dvb libdvbv5) \
		--disable-qv4l2 \
		--disable-qvidcap \
		--disable-v4l-utils \
		$(use_with jpeg)
}

src_compile() {
	emake -C lib
}

src_install() {
	emake -j1 -C lib DESTDIR="${D}" install
	dodoc ChangeLog README.lib* TODO

	# no static archives
	find "${D}" -name '*.la' -delete || die
}