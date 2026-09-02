# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="MLT Multimedia Framework"
HOMEPAGE="https://www.mltframework.org https://github.com/mltframework/mlt"
SRC_URI="https://api.github.com/repos/mltframework/mlt/tarball/v7.40.0 -> mlt-7.40.0-bef9d89.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="+ffmpeg frei0r gdk jack opencv qt6 rtaudio +sdl sox +vorbis"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2=
	dev-libs/libxml2:2
	media-libs/libsamplerate
	sci-libs/fftw:3.0=
	ffmpeg? ( media-video/ffmpeg:= )
	frei0r? ( media-plugins/frei0r-plugins )
	gdk? (
	  media-libs/fontconfig:1.0
	  media-libs/libexif
	  x11-libs/gdk-pixbuf:2
	  x11-libs/pango
	)
	jack? (
	  media-libs/ladspa-sdk
	  media-libs/lilv
	  virtual/jack
	)
	opencv? ( media-libs/opencv:= )
	qt6? (
	  dev-qt/qtbase:6[gui]
	  dev-qt/qtsvg:6
	  media-libs/libexif
	)
	rtaudio? (
	  media-libs/alsa-lib
	  media-sound/pulseaudio
	)
	sdl? ( media-libs/libsdl2 )
	sox? ( media-sound/sox )
	vorbis? (
	  media-libs/libogg
	  media-libs/libvorbis
	)
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv mltframework-mlt-* ${S}
}


src_configure() {
	local mycmakeargs=(
	  -DBUILD_TESTING=OFF
	  -DBUILD_DOCS=OFF
	  -DCLANG_FORMAT=OFF
	  -DMOD_MOVIT=OFF
	  -DMOD_RUBBERBAND=OFF
	  -DMOD_RNNOISE=OFF
	  -DMOD_VIDSTAB=OFF
	  -DMOD_NDI=OFF
	  -DMOD_SPATIALAUDIO=OFF
	  -DMOD_GLAXNIMATE_QT6=OFF
	  -DMOD_SDL1=OFF
	  -DGPL=ON
	  -DGPL3=$(usex qt6)
	  -DMOD_AVFORMAT=$(usex ffmpeg)
	  -DUSE_AVDEVICE=$(usex ffmpeg)
	  -DMOD_FREI0R=$(usex frei0r)
	  -DMOD_GDK=$(usex gdk)
	  -DMOD_JACKRACK=$(usex jack)
	  -DUSE_LV2=$(usex jack)
	  -DUSE_VST2=$(usex jack)
	  -DMOD_OPENCV=$(usex opencv)
	  -DMOD_QT6=$(usex qt6)
	  -DMOD_RTAUDIO=$(usex rtaudio)
	  -DMOD_SDL2=$(usex sdl)
	  -DMOD_SOX=$(usex sox)
	  -DMOD_VORBIS=$(usex vorbis)
	)
	cmake_src_configure
}



# vim: filetype=ebuild
