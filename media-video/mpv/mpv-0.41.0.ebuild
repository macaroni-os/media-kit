# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
LUA_COMPAT=( lua5-1 luajit )
PYTHON_REQ_USE='threads(+)'
inherit meson bash-completion-r1 flag-o-matic lua-single pax-utils python-single-r1 xdg

DESCRIPTION="Command line media player"
HOMEPAGE="https://mpv.io/ https://github.com/mpv-player/mpv"
SRC_URI="https://api.github.com/repos/mpv-player/mpv/tarball/v0.41.0 -> mpv-0.41.0-41f6a64.tar.gz"
LICENSE="LGPL-2.1+ GPL-2+ BSD ISC"
SLOT="0"
KEYWORDS="*"
IUSE="+alsa aqua archive bluray cdda +cli coreaudio cplugins cuda debug doc +drm
dvb dvd +egl gamepad gbm +iconv jack javascript jpeg lcms libass libcaca libmpv
+lua luajit openal +opengl pipewire pulseaudio rubberband sdl sixel
sndio selinux tools +uchardet vaapi vdpau vulkan wayland +X +xv zlib zimg
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
|| ( cli libmpv )
aqua? ( opengl )
cuda? ( opengl )
egl? ( || ( gbm X wayland ) )
gamepad? ( sdl )
gbm? ( drm egl opengl )
lcms? ( opengl )
luajit? ( lua )
opengl? ( || ( aqua egl X !cli ) )
tools? ( cli )
uchardet? ( iconv )
vaapi? ( || ( gbm X wayland ) )
vdpau? ( X )
vulkan? ( || ( X wayland ) )
wayland? ( egl )
X? ( egl? ( opengl ) )
xv? ( X )
"
# Commons depends
CDEPEND="!!app-shells/mpv-bash-completion
	media-libs/libplacebo:=[vulkan?]
	>=media-video/ffmpeg-4.0:0=[encode,threads,vaapi?,vdpau?]
	alsa? ( media-libs/alsa-lib )
	archive? ( app-arch/libarchive:= )
	bluray? ( media-libs/libbluray:= )
	cdda? (
	    dev-libs/libcdio-paranoia
	    dev-libs/libcdio:=
	)
	drm? ( x11-libs/libdrm )
	dvd? ( media-libs/libdvdnav )
	egl? (
	  media-libs/libglvnd
	  media-libs/libplacebo[opengl]
	  media-libs/mesa[egl,gbm(-)?,wayland(-)?]
	)
	gamepad? ( media-libs/libsdl2 )
	iconv? (
	  virtual/libiconv
	  uchardet? ( app-i18n/uchardet )
	)
	jack? ( virtual/jack )
	javascript? ( dev-lang/mujs )
	jpeg? ( virtual/jpeg:0 )
	lcms? ( media-libs/lcms:2 )
	libass? (
	  media-libs/libass:=[fontconfig,harfbuzz(+)]
	  virtual/ttf-fonts
	)
	libcaca? ( media-libs/libcaca )
	lua? (
	  !luajit? ( <dev-lang/lua-5.3:= )
	  luajit? ( dev-lang/luajit:2 )
	)
	openal? ( media-libs/openal )
	pipewire? ( media-video/pipewire )
	pulseaudio? ( media-sound/pulseaudio )
	rubberband? ( media-libs/rubberband )
	sdl? ( media-libs/libsdl2[sound,threads,video] )
	vaapi? ( x11-libs/libva:=[drm?,X?,wayland?] )
	vdpau? ( x11-libs/libvdpau )
	vulkan? (
	  media-libs/libplacebo:=[vulkan]
	  media-libs/shaderc
	)
	wayland? (
	  dev-libs/wayland
	  x11-libs/libxkbcommon
	  vulkan? ( media-libs/vulkan-loader[wayland] )
	)
	X? (
	  x11-libs/libX11
	  x11-libs/libXScrnSaver
	  x11-libs/libXext
	  x11-libs/libXinerama
	  x11-libs/libXrandr
	  x11-libs/libXpresent
	  opengl? (
	    x11-libs/libXdamage
	    virtual/opengl
	  )
	  xv? ( x11-libs/libXv )
	)
	zlib? ( sys-libs/zlib )
	zimg? ( media-libs/zimg )
	
"
BDEPEND="${PYTHON_DEPS}
	dev-util/meson
	virtual/pkgconfig
	cli? ( dev-python/docutils )
	wayland? ( dev-util/wayland-scanner )
	
"
RDEPEND="${CDEPEND}
	cuda? ( x11-drivers/nvidia-drivers[X] )
	tools? ( ${PYTHON_DEPS} )
	
"
DEPEND="${CDEPEND}
	${PYTHON_DEPS}
	X? ( x11-base/xorg-proto )
	dvb? ( sys-kernel/linux-headers )
	cuda? ( media-libs/nv-codec-headers )
	vulkan? ( dev-util/vulkan-headers )
	wayland? ( dev-libs/wayland-protocols )
	
"
post_src_unpack() {
	mv "${WORKDIR}"/mpv-* "${S}" || die
}
pkg_setup() {
	use lua && lua-single_pkg_setup
	python-single-r1_pkg_setup
}

src_configure() {
	if use !debug; then
	  append-cppflags -DNDEBUG # treated specially
	fi
	 local emesonargs=(
	  $(meson_use cli cplayer)
	  $(meson_use libmpv)
	  -Dtests=false
	  $(meson_feature doc html-build)
	  $(meson_feature doc manpage-build)
	  -Dpdf-build=disabled
	   -Dbuild-date=false
	   # misc options
	  $(meson_feature archive libarchive)
	  $(meson_feature bluray libbluray)
	  $(meson_feature cdda)
	  -Dcplugins=enabled
	  $(meson_feature dvb dvbin)
	  $(meson_feature dvd dvdnav)
	  $(meson_feature gamepad sdl2-gamepad)
	  $(meson_feature iconv)
	  $(meson_feature javascript)
	  -Dlibavdevice=enabled
	  $(meson_feature lcms lcms2)
	  # force using lua for pkg-config and lua5.1
	  #-Dlua=$(usex lua "${ELUA}" disabled)
	  -Dlua=$(usex lua "lua" disabled)
	  $(meson_feature rubberband)
	  $(meson_feature uchardet)
	  -Dvapoursynth=disabled # only available in overlays
	  $(meson_feature zimg)
	  $(meson_feature zlib)
	   # audio output
	  $(meson_feature alsa)
	  $(meson_feature coreaudio)
	  $(meson_feature jack)
	  $(meson_feature openal)
	  $(meson_feature pipewire)
	  $(meson_feature pulseaudio pulse)
	  $(meson_feature sdl sdl2-audio)
	  $(meson_feature sndio)
	   # video output
	  $(meson_feature X x11)
	  $(meson_feature aqua cocoa)
	  $(meson_feature drm)
	  $(meson_feature jpeg)
	  $(meson_feature libcaca caca)
	  $(meson_feature sdl sdl2-video)
	  $(meson_feature sixel)
	  $(meson_feature wayland)
	  $(meson_feature xv)
	   -Dgl=$(use aqua || use egl || use libmpv &&
	    echo enabled || echo disabled)
	  $(meson_feature egl)
	  $(meson_feature libmpv plain-gl)
	   $(meson_feature vulkan)
	   # hardware decoding
	  $(meson_feature cuda cuda-hwaccel)
	  $(meson_feature vaapi)
	  $(meson_feature vdpau)
	)
	 meson_src_configure
}

src_install() {
	meson_src_install
	 if use lua; then
	  insinto /usr/share/${PN}
	  doins -r TOOLS/lua
	   if use cli && use lua_single_target_luajit; then
	    pax-mark -m "${ED}"/usr/bin/${PN}
	  fi
	fi
	 if use tools; then
	  dobin TOOLS/{mpv_identify.sh,umpv}
	  newbin TOOLS/idet.sh mpv_idet.sh
	  python_fix_shebang "${ED}"/usr/bin/umpv
	fi
	 if use doc; then
	  dodir /usr/share/doc/${PF}/html
	  #mv "${ED}"/usr/share/doc/{mpv,${PF}/html}/mpv.html || die
	  mv "${ED}"/usr/share/doc/{mpv,${PF}/examples} || die
	fi
	 local GLOBIGNORE=*/*build*:*/*policy*
	dodoc RELEASE_NOTES DOCS/*.{md,rst}
}
pkg_postinst() {
	xdg_pkg_postinst
}
pkg_postrm() {
	xdg_pkg_postrm
}


# vim: filetype=ebuild
