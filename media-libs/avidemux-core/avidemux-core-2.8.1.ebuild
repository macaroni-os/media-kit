# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake flag-o-matic toolchain-funcs

DESCRIPTION="Core libraries for simple video cutting, filtering and encoding tasks"
HOMEPAGE="http://fixounet.free.fr/avidemux"
SRC_URI="https://api.github.com/repos/mean00/avidemux2/tarball/2.8.1 -> avidemux-2.8.1.tar.gz"

# Multiple licenses because of all the bundled stuff.
LICENSE="GPL-1 GPL-2 MIT PSF-2 public-domain"
SLOT="$(ver_cut 1-2)"
KEYWORDS="*"
IUSE="debug nls sdl system-ffmpeg vaapi vdpau xv"

# Trying to use virtual; ffmpeg misses aac,cpudetection USE flags now though, are they needed?
DEPEND="
	dev-db/sqlite:3
	sdl? ( media-libs/libsdl:0 )
	system-ffmpeg? ( >=media-video/ffmpeg-9:0[mp3,theora] )
	vaapi? ( x11-libs/libva:0= )
	vdpau? ( x11-libs/libvdpau:0 )
	xv? ( x11-libs/libXv:0 )
"
RDEPEND="
	${DEPEND}
	!<media-libs/avidemux-core-${PV}
	!<media-video/avidemux-${PV}
	nls? ( virtual/libintl:0 )
"
BDEPEND="
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	!system-ffmpeg? ( dev-lang/yasm[nls=] )
"

PATCHES=( "${FILESDIR}"/avidemux-core-2.7.6-ffmpeg-flags.patch )

S="${WORKDIR}/avidemux2-${PV}"
CMAKE_USE_DIR="${S}/${PN/-/_}"

post_src_unpack() {
	if [ ! -d "${S}" ]; then
	mv mean00-avidemux2* "${S}" || die
	fi
}

src_prepare() {
	cmake_src_prepare

	if use system-ffmpeg ; then
		# Preparations to support the system ffmpeg. Currently fails because
		# it depends on files the system ffmpeg doesn't install.
		local error="Failed to remove bundled ffmpeg."

		rm -r cmake/admFFmpeg* cmake/ffmpeg* avidemux_core/ffmpeg_package buildCore/ffmpeg || die "${error}"
		sed -e 's/include(admFFmpegUtil)//g' -e '/registerFFmpeg/d' -i avidemux/commonCmakeApplication.cmake || die "${error}"
		sed -e 's/include(admFFmpegBuild)//g' -i avidemux_core/CMakeLists.txt || die "${error}"
	else
		local ffmpeg_args=(
			--cc=$(tc-getCC)
			--cxx=$(tc-getCXX)
			--ar=$(tc-getAR)
			--nm=$(tc-getNM)
			--ranlib=$(tc-getRANLIB)
			"--optflags='${CFLAGS}'"
		)

		sed -i -e "s/@@GENTOO_FFMPEG_FLAGS@@/${ffmpeg_args[*]}/" cmake/ffmpeg_configure.sh.cmake || die
	fi
}

src_configure() {
	# See bug 432322.
	use x86 && replace-flags -O0 -O1
	# Bug 768210
	append-cxxflags -std=gnu++14

	local mycmakeargs=(
		-DAVIDEMUX_SOURCE_DIR='${S}'
		-DGETTEXT="$(usex nls)"
		-DNVENC=no
		-DSDL="$(usex sdl)"
		-DLIBVA="$(usex vaapi)"
		-DVDPAU="$(usex vdpau)"
		-DXVIDEO="$(usex xv)"
	)

	use debug && mycmakeargs+=( -DVERBOSE=1 -DADM_DEBUG=1 )

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
}