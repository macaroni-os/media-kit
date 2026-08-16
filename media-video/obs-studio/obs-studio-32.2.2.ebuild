# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
CMAKE_REMOVE_MODULES_LIST=( FindFreetype )
LUA_COMPAT=( luajit )
QA_PREBUILT="
usr/lib*/obs-plugins/chrome-sandbox
usr/lib*/obs-plugins/libcef.so
usr/lib*/obs-plugins/libEGL.so
usr/lib*/obs-plugins/libGLESv2.so
usr/lib*/obs-plugins/libvk_swiftshader.so
usr/lib*/obs-plugins/libvulkan.so.1
"

inherit cmake lua-single optfeature python-single-r1 xdg

DESCRIPTION="Software for Recording and Streaming Live Video Content"
HOMEPAGE="https://obsproject.com"
SRC_URI="
https://api.github.com/repos/obsproject/obs-studio/tarball/32.2.2 -> obs-studio-32.2.2.tar.gz
browser? ( https://cdn-fastly.obsproject.com/downloads/cef_binary_6533_linux_x86_64_v6.tar.xz -> obs-studio-cef-binary-6533-x86-64_v6.tar.xz )
mirror://macaroni/obs-studio-32.2.2-mark-gitsubmodules-bundle-ba2f32b.tar.xz -> obs-studio-32.2.2-mark-gitsubmodules-bundle-ba2f32b.tar.xz"
LICENSE="Boost-1.0 GPL-2+ MIT Unlicense"
SLOT="0"
KEYWORDS="*"
IUSE="+alsa browser decklink fdk jack lua nvenc pipewire pulseaudio
python qsv speex +ssl truetype v4l vlc wayland webrtc websocket
"
REQUIRED_USE="browser? ( || ( alsa pulseaudio ) )
lua? ( ${LUA_REQUIRED_USE} )
python? ( ${PYTHON_REQUIRED_USE} )
"
BDEPEND="lua? ( dev-lang/swig )
	python? ( dev-lang/swig )
	
"
RDEPEND="dev-libs/glib:2
	dev-libs/jansson:=
	dev-libs/simde
	dev-libs/uthash
	media-libs/libglvnd
	x11-libs/libva
	media-libs/x264:=
	net-misc/curl
	sys-apps/dbus
	sys-apps/pciutils
	sys-apps/util-linux
	sys-libs/zlib:=
	>=media-video/ffmpeg-6.1:=[opus,x264]
	dev-cpp/nlohmann_json
	net-libs/mbedtls:=
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXfixes
	x11-libs/libxcb:=
	alsa? ( media-libs/alsa-lib )
	browser? (
	    || (
	        >=app-accessibility/at-spi2-core-2.46.0:2
	        ( app-accessibility/at-spi2-atk dev-libs/atk )
	    )
	    dev-libs/expat
	    dev-libs/glib
	    dev-libs/nspr
	    dev-libs/nss
	    dev-libs/wayland
	    media-libs/alsa-lib
	    media-libs/fontconfig
	    media-libs/mesa[gbm(+)]
	    net-print/cups
	    x11-libs/cairo
	    x11-libs/libdrm
	    x11-libs/libXcursor
	    x11-libs/libXdamage
	    x11-libs/libXext
	    x11-libs/libXi
	    x11-libs/libxkbcommon
	    x11-libs/libXrandr
	    x11-libs/libXrender
	    x11-libs/libXScrnSaver
	    x11-libs/libxshmfence
	    x11-libs/libXtst
	    x11-libs/pango
	)
	fdk? ( media-libs/fdk-aac:= )
	jack? ( virtual/jack )
	lua? ( ${LUA_DEPS} )
	nvenc? ( media-libs/nv-codec-headers )
	pipewire? ( media-video/pipewire:= )
	pulseaudio? ( media-sound/pulseaudio )
	python? ( ${PYTHON_DEPS} )
	qsv? (
	    media-libs/libvpl
	    x11-libs/libva
	)
	>=dev-qt/qtbase-6.8:6[xml(+)]
	>=dev-qt/qtsvg-6.8:6
	x11-libs/libxkbcommon
	speex? ( media-libs/speexdsp )
	truetype? (
	    media-libs/fontconfig
	    media-libs/freetype
	)
	v4l? (
	    media-libs/libv4l
	    virtual/udev
	)
	vlc? ( media-video/vlc:= )
	wayland? (
	    dev-libs/wayland
	    x11-libs/libxkbcommon
	)
	webrtc? ( net-libs/libdatachannel )
	websocket? (
	    dev-cpp/asio
	    >=dev-cpp/websocketpp-0.8.2
	    dev-libs/qrcodegencpp
	)
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv obsproject-obs-studio-* ${S}
}


post_src_unpack() {
	local d main_dir bundle_dir
	for d in "${WORKDIR}"/obsproject-obs-studio-*; do
	  if [[ -f ${d}/CMakeLists.txt ]]; then
	    main_dir=${d}
	  else
	    bundle_dir=${d}
	  fi
	done
	 [[ -n ${main_dir} ]] || die "could not locate main obs-studio source directory"
	 if [[ -n ${bundle_dir} && ${bundle_dir} != "${main_dir}" ]]; then
	  cp -r "${bundle_dir}"/plugins/. "${main_dir}"/plugins/ || die
	fi
	 mv "${main_dir}" "${S}" || die
}

pkg_setup() {
	use lua && lua-single_pkg_setup
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	default
	cmake_src_prepare
}

src_configure() {
	local libdir=$(get_libdir)
	local mycmakeargs=(
	  -DENABLE_ALSA=$(usex alsa)
	  -DENABLE_AJA=OFF
	  -DENABLE_BROWSER=$(usex browser)
	  -DENABLE_DECKLINK=$(usex decklink)
	  -DENABLE_FREETYPE=$(usex truetype)
	  -DENABLE_JACK=$(usex jack)
	  -DENABLE_LIBFDK=$(usex fdk)
	  -DENABLE_NEW_MPEGTS_OUTPUT=OFF # Requires librist and libsrt.
	  -DENABLE_NVENC=$(usex nvenc)
	  -DENABLE_PIPEWIRE=$(usex pipewire)
	  -DENABLE_PULSEAUDIO=$(usex pulseaudio)
	  -DENABLE_QSV11=$(usex qsv)
	  -DENABLE_RNNOISE=ON
	  -DENABLE_SPEEXDSP=$(usex speex)
	  -DENABLE_V4L2=$(usex v4l)
	  -DENABLE_VLC=$(usex vlc)
	  -DENABLE_VST=ON
	  -DENABLE_WAYLAND=$(usex wayland)
	  -DENABLE_WEBRTC=$(usex webrtc)
	  -DENABLE_WEBSOCKET=$(usex websocket)
	  -DOBS_VERSION_OVERRIDE=${PV}
	)
	 if use browser; then
	  mycmakeargs+=( -DCEF_ROOT_DIR="${WORKDIR}/cef_binary_6533_linux_x86_64" )
	fi
	 if use lua || use python; then
	  mycmakeargs+=(
	    -DENABLE_SCRIPTING_LUA=$(usex lua)
	    -DENABLE_SCRIPTING_PYTHON=$(usex python)
	    -DENABLE_SCRIPTING=ON
	  )
	else
	  mycmakeargs+=( -DENABLE_SCRIPTING=OFF )
	fi
	 if use browser && use ssl; then
	  mycmakeargs+=( -DENABLE_WHATSNEW=ON )
	else
	  mycmakeargs+=( -DENABLE_WHATSNEW=OFF )
	fi
	 cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	 if ! use alsa && ! use pulseaudio; then
	  elog
	  elog "For the audio capture features to be available,"
	  elog "at least one of the 'alsa' or 'pulseaudio' USE-flags needs to"
	  elog "be enabled."
	  elog
	fi
	 if use v4l && has_version media-video/v4l2loopback; then
	  elog
	  elog "Depending on system configuration, the v4l2loopback kernel module"
	  elog "may need to be loaded manually, and needs to be re-built after"
	  elog "kernel changes."
	  elog
	fi
	 optfeature "VA-API hardware encoding" media-video/ffmpeg[vaapi]
	optfeature "virtual camera support" media-video/v4l2loopback
}



# vim: filetype=ebuild
