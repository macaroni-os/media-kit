# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit flag-o-matic cmake python-r1 xdg-utils

DESCRIPTION="Open Source Computer Vision Library"
HOMEPAGE="https://opencv.org"
SRC_URI="
https://github.com/opencv/opencv/archive/refs/tags/4.14.0.tar.gz -> opencv-4.14.0-0654a42.tar.gz
https://github.com/opencv/ade/archive/v0.1.2e.tar.gz -> opencv-ade-0.1.2e.tar.gz
contrib? ( https://github.com/opencv/opencv_contrib/archive/refs/tags/4.14.0.tar.gz -> opencv-contrib-4.14.0.tar.gz )"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="debug doc +eigen non-free opencvapps python
examples features2d
contrib contribcvv contribfreetype contribhdf contribovis contribsfm
contribxfeatures2d
opencl video_cards_intel
+ffmpeg gphoto2 gstreamer ieee1394 vaapi v4l
avif gif jasper jpeg jpeg2k openexr png quirc
tiff webp gtk3 qt6 opengl truetype vtk vulkan wayland openmp tbb
lapack
cpu_flags_arm_neon
cpu_flags_arm_vfpv3
cpu_flags_arm_asimddp
cpu_flags_x86_sse
cpu_flags_x86_sse2
cpu_flags_x86_sse3
cpu_flags_x86_ssse3
cpu_flags_x86_sse4_1
cpu_flags_x86_popcnt
cpu_flags_x86_sse4_2
cpu_flags_x86_f16c
cpu_flags_x86_fma3
cpu_flags_x86_avx
cpu_flags_x86_avx2
cpu_flags_x86_avx512_bitalg
cpu_flags_x86_avx512_vbmi2
cpu_flags_x86_avx512_vnni
cpu_flags_x86_avx512_vpopcntdq
cpu_flags_x86_avx512bw
cpu_flags_x86_avx512cd
cpu_flags_x86_avx512dq
cpu_flags_x86_avx512f
cpu_flags_x86_avx512ifma
cpu_flags_x86_avx512vbmi
cpu_flags_x86_avx512vl
cpu_flags_x86_avx512er
cpu_flags_x86_avx512pf
cpu_flags_x86_avx512_4fmaps
cpu_flags_x86_avx512_4vnniw
"
REQUIRED_USE="amd64? (
  cpu_flags_x86_sse
  cpu_flags_x86_sse2
  cpu_flags_x86_avx2? ( cpu_flags_x86_f16c )
  cpu_flags_x86_f16c? ( cpu_flags_x86_avx )
  cpu_flags_x86_avx512er? ( cpu_flags_x86_avx512pf )
  cpu_flags_x86_avx512pf? ( cpu_flags_x86_avx512er )
  cpu_flags_x86_avx512_4fmaps? ( cpu_flags_x86_avx512_4fmaps )
  cpu_flags_x86_avx512_4vnniw? ( cpu_flags_x86_avx512_4vnniw )
)
opengl? ( || ( gtk3 qt6 wayland ) )
python? ( ${PYTHON_REQUIRED_USE} )
wayland? ( !vtk )
contribcvv? ( contrib qt6 )
contribfreetype? ( contrib )
contribhdf? ( contrib )
contribovis? ( contrib )
contribsfm? ( contrib )
contribxfeatures2d? ( contrib )
"
# Commons depends
CDEPEND="dev-libs/protobuf:=
	sys-libs/zlib
	avif? ( media-libs/libavif:= )
	ffmpeg? ( media-video/ffmpeg:= )
	gphoto2? ( media-libs/libgphoto2:= )
	gstreamer? (
	  media-libs/gstreamer
	  media-libs/gst-plugins-base
	)
	gtk3? (
	  dev-libs/glib:2
	  x11-libs/gtk+:3
	)
	ieee1394? (
	  media-libs/libdc1394:=
	  sys-libs/libraw1394
	)
	jpeg? ( media-libs/libjpeg-turbo:= )
	jpeg2k? (
	  jasper? ( media-libs/jasper:= )
	  !jasper? ( media-libs/openjpeg:= )
	)
	lapack? (
	  virtual/cblas
	  virtual/lapack
	)
	opencl? (
	  virtual/opencl
	  dev-util/opencl-headers
	)
	openexr? (
	  dev-libs/imath:=
	  media-libs/openexr:=
	)
	png? (
	  media-libs/libpng:=
	)
	python? (
	  ${PYTHON_DEPS}
	  dev-python/numpy:=[${PYTHON_USEDEP}]
	)
	qt6? (
	  dev-qt/qt5compat:6
	  dev-qt/qtbase:6[gui]
	)
	quirc? ( media-libs/quirc:= )
	tbb? ( dev-cpp/tbb:= )
	v4l? ( media-libs/libv4l )
	vaapi? ( media-libs/libva )
	webp? ( media-libs/libwebp:= )
	vulkan? ( media-libs/vulkan-loader )
	wayland? (
	  x11-libs/libxkbcommon
	  dev-libs/wayland
	  dev-libs/wayland-protocols
	)
	contribhdf? ( sci-libs/hdf5:= )
	contribfreetype? (
	  media-libs/freetype:2
	  media-libs/harfbuzz:=
	)
	contribovis? ( dev-games/ogre:= )
	
"
BDEPEND="dev-util/patchelf
	virtual/pkgconfig
	doc? (
	  app-text/doxygen[dot]
	  python? (
	    dev-python/beatifulsoup4[${PYTHON_USEDEP}]
	  )
	)
	
"
RDEPEND="${CDEPEND}
	
"
DEPEND="${CDEPEND}
	eigen? ( dev-cpp/eigen )
	
"

CPU_FEATURES_MAP=(
	cpu_flags_arm_neon:NEON
	cpu_flags_arm_vfpv3:VFPV3
	cpu_flags_arm_asimddp:NEON_DOTPROD
	cpu_flags_x86_sse:SSE
	cpu_flags_x86_sse2:SSE2
	cpu_flags_x86_sse3:SSE3
	cpu_flags_x86_ssse3:SSSE3
	cpu_flags_x86_sse4_1:SSE4_1
	cpu_flags_x86_popcnt:POPCNT
	cpu_flags_x86_sse4_2:SSE4_2
	cpu_flags_x86_f16c:FP16
	cpu_flags_x86_fma3:FMA3
	cpu_flags_x86_avx:AVX
	cpu_flags_x86_avx2:AVX2
	cpu_flags_x86_avx512_bitalg:AVX_512BITALG
	cpu_flags_x86_avx512_vbmi2:AVX_512VBMI2
	cpu_flags_x86_avx512_vnni:AVX_512VNNI
	cpu_flags_x86_avx512_vpopcntdq:AVX_512VPOPCNTDQ
	cpu_flags_x86_avx512bw:AVX_512BW
	cpu_flags_x86_avx512cd:AVX_512CD
	cpu_flags_x86_avx512dq:AVX_512DQ
	cpu_flags_x86_avx512f:AVX_512F
	cpu_flags_x86_avx512ifma:AVX_512IFMA
	cpu_flags_x86_avx512vbmi:AVX_512VBMI
	cpu_flags_x86_avx512vl:AVX_512VL
	cpu_flags_x86_avx512er:AVX_512ER
	cpu_flags_x86_avx512pf:AVX_512PF
	cpu_flags_x86_avx512_4fmaps:AVX_5124FMAPS
	cpu_flags_x86_avx512_4vnniw:AVX_5124VNNIW
)
pkg_pretend() {
	use openmp && tc-check-openmp
}
pkg_setup() {
	use openmp && tc-check-openmp
}
src_unpack() {
	local file
	default
	# remove bundle stuff
	local files_3rdparty=(
	  ffmpeg
	  include/{opencl,vulkan}
	  libjasper
	  libjpeg
	  libjpeg-turbo
	  libpng
	  libspng
	  libtiff
	  libwebp
	  openexr
	  openjpeg
	  protobuf
	  quirc
	  tbb
	  zlib
	  zlib-ng
	)
	for file in "${files_3rdparty[@]}"; do
	  rm -r "${S}/3rdparty/${file}" || die "Removing 3rd party components (${file}) failed"
	  sed -e "\_add\_subdirectory(.*3rdparty/${file})_d" \
	    -i "${S}/CMakeLists.txt" "${S}/cmake"/*cmake || die
	done
}
src_prepare() {
	cmake_src_prepare
	sed \
	  -e '/find_package(OpenMP/s/)/ COMPONENTS C CXX)/g' \
	  -i \
	    cmake/OpenCVFindFrameworks.cmake \
	  || die
	if use contrib; then
	  pushd "${WORKDIR}/opencv_contrib-${PV}" >/dev/null || die
	  popd >/dev/null || die
	   ! use contribcvv && { rm -R "${WORKDIR}/opencv_contrib-${PV}/modules/cvv" || die; }
	  ! use contribfreetype && { rm -R "${WORKDIR}/opencv_contrib-${PV}/modules/freetype" || die; }
	  ! use contribhdf && { rm -R "${WORKDIR}/opencv_contrib-${PV}/modules/hdf" || die; }
	  ! use contribovis && { rm -R "${WORKDIR}/opencv_contrib-${PV}/modules/ovis" || die; }
	  ! use contribsfm && { rm -R "${WORKDIR}/opencv_contrib-${PV}/modules/sfm" || die; }
	  ! use contribxfeatures2d && { rm -R "${WORKDIR}/opencv_contrib-${PV}/modules/xfeatures2d" || die; }
	fi
}
src_configure() {
	filter-lto
	append-cppflags "$(usex debug '-DDEBUG' '-DNDEBUG')"
	 local mycmakeargs=(
	  -DMIN_VER_CMAKE=3.26
	  -DCMAKE_POLICY_DEFAULT_CMP0148="OLD" # FindPythonInterp
	  # for protobuf
	  -DCMAKE_CXX_STANDARD=17
	 # Optional 3rd party components
	# ===================================================
	  -DOPENCV_ENABLE_NONFREE="$(usex non-free)"
	  -DWITH_QUIRC="$(usex quirc)"
	  -DWITH_FLATBUFFERS="no"
	  -DWITH_1394="$(usex ieee1394)"
	  # -DWITH_AVFOUNDATION="no" # IOS
	  -DWITH_VTK="no"
	  -DWITH_EIGEN="$(usex eigen)"
	  -DWITH_VFW="no" # Video windows support
	  -DWITH_FFMPEG="$(usex ffmpeg)"
	  -DWITH_GSTREAMER="$(usex gstreamer)"
	  -DWITH_GTK="$(usex gtk3)"
	  -DWITH_GTK_2_X="no" # only want gtk3 nowadays
	  -DWITH_IMGCODEC_GIF="$(usex gif)"
	  -DWITH_IPP="no"
	  -DWITH_JULIA="no"
	  -DWITH_JASPER="$(usex jpeg2k "$(usex jasper)")"
	  -DWITH_JPEG="$(usex jpeg)"
	  -DWITH_OPENJPEG="$(usex jpeg2k "$(usex !jasper)")"
	  -DWITH_WEBP="$(usex webp)"
	  -DWITH_OPENEXR="$(usex openexr)"
	  -DWITH_OPENVX="no"
	  -DWITH_OPENNI="no"
	  -DWITH_OPENNI2="no"
	  -DWITH_PNG="$(usex png)"
	  -DWITH_SPNG="no"
	  -DWITH_GDCM="no"
	  -DWITH_PVAPI="no"
	  -DWITH_GIGEAPI="no"
	  -DWITH_ARAVIS="no"
	  -DWITH_WIN32UI="no" # Windows only
	  -DWITH_TBB="$(usex tbb)"
	  -DWITH_OPENMP="$(usex openmp)"
	  -DWITH_PTHREADS_PF="yes"
	  -DWITH_TIFF="$(usex tiff)"
	  -DWITH_UNICAP="no"               # Not packaged
	  -DWITH_V4L="$(usex v4l)"
	  -DWITH_LIBV4L="$(usex v4l)"
	  -DWITH_MSMF="no"
	  -DWITH_XIMEA="no"        # Windows only
	  -DWITH_XINE="no"
	  -DWITH_CLP="no"
	  -DWITH_OPENCL="$(usex opencl)"
	  -DWITH_OPENCL_SVM="no" # "$(usex opencl)"
	  -DWITH_DIRECTX="no"
	  -DWITH_INTELPERC="no"
	  -DWITH_IPP_A="no"
	  -DWITH_MATLAB="no"
	  -DWITH_VA="$(usex vaapi)"
	  -DWITH_VA_INTEL="$(usex vaapi "$(usex video_cards_intel)")"
	  -DWITH_GDAL="no"
	  -DWITH_GPHOTO2="$(usex gphoto2)"
	  -DWITH_LAPACK="$(usex lapack)"
	  -DWITH_ITT="no" # 3dparty libs itt_notify
	   -DWITH_AVIF="$(usex avif)"
	  -DWITH_FREETYPE="$(usex truetype)"
	  -DWITH_VULKAN="$(usex vulkan)"
	  -DWITH_WAYLAND="$(usex wayland)"
	# ===================================================
	# CUDA build components: nvidia-cuda-toolkit
	# ===================================================
	  -DWITH_CUDA="no"
	  -DWITH_CUBLAS="no"
	  -DWITH_CUFFT="no"
	  -DWITH_CUDNN="no"
	  -DWITH_NVCUVID="no"
	  -DWITH_NVCUVENC="no"
	  -DCUDA_NPP_LIBRARY_ROOT_DIR=""
	# ===================================================
	# OpenCV build components
	# ===================================================
	  -DBUILD_SHARED_LIBS="yes"
	  -DBUILD_JAVA="no"
	  -DBUILD_ANDROID_EXAMPLES="no"
	  -DBUILD_opencv_apps="$(usex opencvapps)"
	  -DBUILD_DOCS="$(usex doc)" # Doesn't install anyways.
	  -DBUILD_EXAMPLES="$(usex examples)"
	  -DBUILD_TESTS="no"
	  -DBUILD_PERF_TESTS="no"
	   # -DBUILD_WITH_STATIC_CRT="no"
	  -DBUILD_WITH_DYNAMIC_IPP="no"
	  -DBUILD_FAT_JAVA_LIB="no"
	  # -DBUILD_ANDROID_SERVICE="no"
	  -DBUILD_CUDA_STUBS="no"
	  -DOPENCV_EXTRA_MODULES_PATH="$(usex contrib "${WORKDIR}/${PN}_contrib-${PV}/modules" "")"
	# ===================================================
	# OpenCV installation options
	# ===================================================
	  -DINSTALL_CREATE_DISTRIB="no"
	  -DINSTALL_BIN_EXAMPLES="$(usex examples)"
	  -DINSTALL_C_EXAMPLES="$(usex examples)"
	  -DINSTALL_TESTS="no"
	  # -DINSTALL_ANDROID_EXAMPLES="no"
	  -DINSTALL_TO_MANGLED_PATHS="no"
	  -DOPENCV_GENERATE_PKGCONFIG="yes"
	  # opencv uses both ${CMAKE_INSTALL_LIBDIR} and ${LIB_SUFFIX}
	  # to set its destination libdir
	  -DLIB_SUFFIX=
	# ===================================================
	# OpenCV build options
	# ===================================================
	  -DENABLE_CCACHE="no"
	  # bug 733796, but PCH is a risky game in CMake anyway
	  -DBUILD_USE_SYMLINKS="yes"
	  -DENABLE_PRECOMPILED_HEADERS="no"
	  -DENABLE_SOLUTION_FOLDERS="no"
	  -DENABLE_PROFILING="no"
	  -DENABLE_COVERAGE="no"
	  -DOPENCV_DOWNLOAD_TRIES_LIST="0"
	  -DHAVE_opencv_java="no"
	  -DBUILD_WITH_DEBUG_INFO="$(usex debug)"
	  -DOPENCV_ENABLE_MEMORY_SANITIZER="$(usex debug)"
	  -DCV_TRACE="$(usex debug)"
	  -DENABLE_NOISY_WARNINGS="$(usex debug)"
	  -DOPENCV_WARNINGS_ARE_ERRORS="no"
	  -DENABLE_IMPL_COLLECTION="no"
	  -DENABLE_INSTRUMENTATION="no"
	  -DGENERATE_ABI_DESCRIPTOR="no"
	# ===================================================
	# things we want to be hard off or not yet figured out
	# ===================================================
	  -DBUILD_PACKAGE="no"
	# ===================================================
	# Not building protobuf but update files bug #631418
	# ===================================================
	  -DWITH_PROTOBUF="yes"
	  -DBUILD_PROTOBUF="no"
	  -DPROTOBUF_UPDATE_FILES="yes"
	  -DProtobuf_MODULE_COMPATIBLE="yes"
	# ===================================================
	# things we want to be hard enabled not worth useflag
	# ===================================================
	  -DOPENCV_DOC_INSTALL_PATH="share/doc/${PF}"
	  -DOPENCV_SAMPLES_BIN_INSTALL_PATH="libexec/opencv/bin/samples"
	   -DBUILD_IPP_IW="no"
	  -DBUILD_ITT="no"
	 # ===================================================
	# configure modules to be build
	# ===================================================
	  -DBUILD_opencv_dnn="no"
	  -DBUILD_opencv_gapi="$(usex ffmpeg yes "$(usex gstreamer)")"
	  -DBUILD_opencv_features2d="$(usex features2d)"
	  -DBUILD_opencv_java_bindings_generator="no"
	  -DBUILD_opencv_wechat_qrcode="no"
	  -DBUILD_opencv_julia="no"
	  -DBUILD_opencv_js="no"
	  -DBUILD_opencv_js_bindings_generator="no"
	  -DBUILD_opencv_objc_bindings_generator="no"
	  -DBUILD_opencv_python2="no"
	  -DBUILD_opencv_ts="no"
	  -DBUILD_opencv_video="$(usex ffmpeg yes "$(usex gstreamer)")"
	  -DBUILD_opencv_videoio="$(usex ffmpeg yes "$(usex gstreamer)")"
	   -DBUILD_opencv_cudalegacy="no"
	   # -DBUILD_opencv_world="yes"
	   -DOPENCV_PLUGIN_VERSION=".414"
	  -DOPENCV_PLUGIN_ARCH=".${ARCH}"
	   -DDNN_PLUGIN_LIST="all"
	  -DHIGHGUI_ENABLE_PLUGINS="no"
	   -DOPENCV_SKIP_SAMPLES_SYCL="yes"
	)
	 local VIDEOIO_PLUGIN_LIST=()
	if use ffmpeg; then
	  VIDEOIO_PLUGIN_LIST+=("ffmpeg")
	fi
	if use gstreamer; then
	  VIDEOIO_PLUGIN_LIST+=("gstreamer")
	fi
	 mycmakeargs+=(
	  -DVIDEOIO_PLUGIN_LIST="$(IFS=';'; echo "${VIDEOIO_PLUGIN_LIST[*]}")"
	)
	if use qt6; then
	  mycmakeargs+=(
	    -DWITH_QT="$(usex qt6)"
	    -DCMAKE_DISABLE_FIND_PACKAGE_Qt5="yes"
	  )
	else
	  mycmakeargs+=(
	    -DWITH_QT="no"
	    -DCMAKE_DISABLE_FIND_PACKAGE_Qt5="yes"
	    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6="yes"
	  )
	fi
	local CPU_BASELINE=""
	for i in "${CPU_FEATURES_MAP[@]}" ; do
	  if [[ ${ABI} != x86 || ${i%:*} != "cpu_flags_x86_avx2" ]]; then
	    local value
	    # These are merged into one flag internally
	    if [[ ${ABI} == amd64 ]]; then
	      case "${i%:*}" in
	        cpu_flags_x86_avx512er|cpu_flags_x86_avx512pf)
	          value="AVX512_KNL_EXTRA"
	          ;;
	        cpu_flags_x86_avx512_4fmaps|cpu_flags_x86_avx512_4vnniw)
	          value="AVX512_KNM_EXTRA"
	          ;;
	        *)
	          value="${i#*:}"
	          ;;
	      esac
	    else
	      value=${i#*:}
	    fi
	    use "${i%:*}" && CPU_BASELINE="${CPU_BASELINE}${value};"
	  fi
	done
	unset CPU_FEATURES_MAP
	mycmakeargs+=(
	  -DCPU_BASELINE="${CPU_BASELINE}"
	)
	 if use contrib; then
	  mycmakeargs+=(
	    -DBUILD_opencv_cvv="$(usex contribcvv)"
	     -DBUILD_opencv_freetype="$(usex contribfreetype)"
	    -DBUILD_opencv_hdf="$(usex contribhdf)"
	    -DBUILD_opencv_ovis="$(usex contribovis)"
	    -DBUILD_opencv_sfm="$(usex contribsfm)"
	    -DBUILD_opencv_xfeatures2d="no"
	    -DWITH_TESSERACT="no"
	  )
	fi
	 tc-export CC CXX
	 if use ffmpeg; then
	  mycmakeargs+=(
	    -DOPENCV_GAPI_GSTREAMER="no"
	    -DOPENCV_FFMPEG_DISABLE_MEDIASDK="yes"
	  )
	fi
	if use lapack; then
	  mycmakeargs+=(
	    -DSKIP_OPENBLAS_PACKAGE="yes"
	    -DOPENCV_LAPACK_DISABLE_MKL="yes"
	  )
	fi
	 if use gtk3 || use qt6 || use wayland; then
	  if use opengl; then
	    mycmakeargs+=(
	      -DWITH_OPENGL="yes"
	      -DOpenGL_GL_PREFERENCE="GLVND"
	    )
	  else
	    mycmakeargs+=(
	      -DWITH_OPENGL="no"
	    )
	  fi
	fi
	 if use opencl; then
	  mycmakeargs+=( -DOPENCL_INCLUDE_DIR="${ESYSROOT}/usr/include" )
	  if has_version sci-libs/clfft; then
	    mycmakeargs+=( -DWITH_OPENCLAMDFFT="yes" )
	  else
	    mycmakeargs+=( -DWITH_OPENCLAMDFFT="no" )
	  fi
	  if has_version sci-libs/clblas; then
	    mycmakeargs+=( -DWITH_OPENCLAMDBLAS="yes" )
	  else
	    mycmakeargs+=( -DWITH_OPENCLAMDBLAS="no" )
	  fi
	else
	  mycmakeargs+=(
	    -DWITH_OPENCLAMDFFT="no"
	    -DWITH_OPENCLAMDBLAS="no"
	  )
	fi
	 if use vulkan; then
	  mycmakeargs+=( -DVULKAN_INCLUDE_DIRS="/usr/include" )
	fi
	 if use python; then
	  python_setup
	  mycmakeargs+=(
	    -DBUILD_opencv_python3="yes"
	    -DBUILD_opencv_python_bindings_generator="yes"
	    -DBUILD_opencv_python_tests="no"
	    -DPYTHON_DEFAULT_EXECUTABLE="${EPYTHON}"
	    -DPYTHON_EXECUTABLE="${EPYTHON}"
	    -DINSTALL_PYTHON_EXAMPLES="$(usex examples)"
	  )
	 else
	  mycmakeargs+=(
	    -DOPENCV_PYTHON_SKIP_DETECTION="yes"
	    -DPYTHON_EXECUTABLE="no"
	    -DINSTALL_PYTHON_EXAMPLES="no"
	    -DBUILD_opencv_python3="no"
	    -DBUILD_opencv_python_bindings_generator="no"
	    -DBUILD_opencv_python_tests="no"
	  )
	fi
	 cmake_src_configure
}
src_compile() {
	cmake_src_compile
}
src_install() {
	cmake_src_install
	for plugin in "${ED}/usr/$(get_libdir)/libopencv_"*".414.${ARCH}"* ; do
	  patchelf --set-soname "$(basename "${plugin}" ".$(get_libname)")" "${plugin}"
	done
}


# vim: filetype=ebuild
