# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="OpenAL Soft is a software implementation of the OpenAL 3D audio API."
HOMEPAGE="https://www.openal-soft.org/"
LICENSE="LGPL-2+ BSD"
SLOT="0"
KEYWORDS="*"
DOCS=(
	alsoftrc.sample
	docs/env-vars.txt
	docs/hrtf.txt
	ChangeLog
	README.md
)
IUSE="alsa coreaudio dbus jack oss pipewire portaudio pulseaudio sdl
sndfile sndio qt6
cpu_flags_x86_sse cpu_flags_x86_sse2 cpu_flags_x86_sse3
cpu_flags_x86_sse4_1 cpu_flags_arm_neon
"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="alsa? ( media-libs/alsa-lib )
	dbus? ( sys-apps/dbus )
	jack? ( virtual/jack )
	pipewire? ( media-video/pipewire )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	qt6? ( dev-qt/qtbase:6[gui] )
	sdl? ( media-libs/libsdl3 )
	sndfile? ( media-libs/libsndfile )
	sndio? ( media-sound/sndio:= )
	
"
DEPEND="${RDEPEND}
	oss? ( virtual/os-headers )
	
"

post_src_unpack() {
	mv kcat-openal-soft-* ${S}
}


src_configure() {
	local mycmakeargs=(
	  -DALSOFT_{BACKEND,REQUIRE}_ALSA=$(usex alsa)
	  -DALSOFT_{BACKEND,REQUIRE}_COREAUDIO=$(usex coreaudio)
	  -DALSOFT_{BACKEND,REQUIRE}_JACK=$(usex jack)
	  -DALSOFT_{BACKEND,REQUIRE}_OSS=$(usex oss)
	  -DALSOFT_{BACKEND,REQUIRE}_PIPEWIRE=$(usex pipewire)
	  -DALSOFT_{BACKEND,REQUIRE}_PORTAUDIO=$(usex portaudio)
	  -DALSOFT_{BACKEND,REQUIRE}_PULSEAUDIO=$(usex pulseaudio)
	  -DALSOFT_{BACKEND,REQUIRE}_SDL3=$(usex sdl)
	  -DALSOFT_{BACKEND,REQUIRE}_SDL2=OFF
	  -DALSOFT_{BACKEND,REQUIRE}_SNDIO=$(usex sndio)
	  -DALSOFT_RTKIT=$(usex dbus)
	  -DALSOFT_REQUIRE_RTKIT=$(usex dbus)
	  -DALSOFT_UTILS=ON
	  -DALSOFT_NO_CONFIG_UTIL=$(usex qt6 OFF ON)
	  -DALSOFT_EXAMPLES=OFF
	  -DALSOFT_TESTS=OFF
	  -DCMAKE_DISABLE_FIND_PACKAGE_SndFile=$(usex sndfile OFF ON)
	  -DCMAKE_DISABLE_FIND_PACKAGE_MySOFA=ON
	)
	if use amd64 || use x86 ; then
	  mycmakeargs+=(
	    -DALSOFT_CPUEXT_SSE=$(usex cpu_flags_x86_sse)
	    -DALSOFT_CPUEXT_SSE2=$(usex cpu_flags_x86_sse2)
	    -DALSOFT_CPUEXT_SSE3=$(usex cpu_flags_x86_sse3)
	    -DALSOFT_CPUEXT_SSE4_1=$(usex cpu_flags_x86_sse4_1)
	  )
	fi
	if use arm || use arm64 ; then
	  mycmakeargs+=(
	    -DALSOFT_CPUEXT_NEON=$(usex cpu_flags_arm_neon)
	  )
	fi
	cmake_src_configure
}



# vim: filetype=ebuild
