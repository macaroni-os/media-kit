# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="Meta ebuild to pull in gst plugins for apps"
HOMEPAGE="https://gstreamer.freedesktop.org/"
LICENSE="LGPL-2+"
SLOT="1.0"
KEYWORDS="*"
IUSE="aac a52 alsa cdda dts dv dvb dvd ffmpeg flac http lame
libass libvisual mp3 modplug mpeg ogg opus oss pulseaudio
taglib theora v4l vaapi vcd vorbis vpx wavpack X x264
"
BDEPEND="virtual/perl-JSON-PP
	virtual/pkgconfig
	sys-apps/sed
	
"
RDEPEND=">=media-libs/gstreamer-1.26.10:1.0
	>=media-libs/gst-plugins-base-1.26.10:1.0
	>=media-libs/gst-plugins-good-1.26.10:1.0
	a52? (
	  >=media-libs/gst-plugins-ugly-1.26.10:1.0[a52dec]
	)
	aac? (
	  >=media-libs/gst-plugins-bad-1.26.10:1.0[aac]
	)
	cdda? ( || (
	    >=media-libs/gst-plugins-ugly-1.26.10:1.0[cdio]
	    >=media-libs/gst-plugins-bad-1.26.10:1.0[cdda]
	  )
	)
	dts? (
	  >=media-libs/gst-plugins-bad-1.26.10:1.0[dts]
	)
	dvb? (
	  >=media-libs/gst-plugins-bad-1.26.10:1.0[dvb]
	)
	dvd? (
	  >=media-libs/gst-plugins-ugly-1.26.10:1.0[a52dec,dvdread,mpeg2dec,dvd]
	)
	ffmpeg? (
	  >=media-plugins/gst-plugins-libva-1.26.10:1.0
	)
	flac? (
	  >=media-libs/gst-plugins-good-1.26.10:1.0[flac]
	)
	http? (
	  >=media-libs/gst-plugins-good-1.26.10:1.0[soup]
	)
	lame? (
	  >=media-libs/gst-plugins-good-1.26.10:1.0[lame]
	)
	libass? (
	  >=media-libs/gst-plugins-bad-1.26.10:1.0[libass]
	)
	mp3? (
	  >=media-libs/gst-plugins-good-1.26.10:1.0[mp3]
	)
	opus? (
	  >=media-libs/gst-plugins-bad-1.26.10:1.0[opus]
	)
	mpeg? (
	  >=media-libs/gst-plugins-ugly-1.26.10:1.0[mpeg2dec]
	)
	pulseaudio? (
	  >=media-libs/gst-plugins-good-1.26.10:1.0[pulseaudio]
	)
	modplug? (
	  >=media-libs/gst-plugins-bad-1.26.10:1.0[modplug]
	)
	taglib? (
	  >=media-libs/gst-plugins-good-1.26.10:1.0[taglib]
	)
	v4l? (
	  >=media-libs/gst-plugins-good-1.26.10:1.0[v4l]
	)
	vaapi? (
	  >=media-plugins/gst-plugins-vaapi-1.26.10:1.0
	)
	vcd? (
	  >=media-libs/gst-plugins-ugly-1.26.10:1.0[mpeg2dec]
	  >=media-libs/gst-plugins-bad-1.26.10:1.0[mplex]
	)
	vpx? (
	  >=media-libs/gst-plugins-good-1.26.10:1.0[vpx]
	)
	wavpack? (
	  >=media-libs/gst-plugins-good-1.26.10:1.0[wavpack]
	)
	x264? (
	  >=media-libs/gst-plugins-ugly-1.26.10:1.0[x264]
	)
	
"

# vim: filetype=ebuild
