# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
X86_CPU_FEATURES=( aes:aes sse2:sse2 sse3:sse3 ssse3:ssse3 sse4_1:sse4.1 sse4_2:sse4.2 avx:avx avx2:avx2 avx512f:avx512f f16c:f16c )
CPU_FEATURES=( ${X86_CPU_FEATURES[@]/#/cpu_flags_x86_} )
inherit cmake font python-single-r1 flag-o-matic

DESCRIPTION="A library for reading and writing images"
HOMEPAGE="https://openimageio.org/ https://github.com/AcademySoftwareFoundation/OpenImageIO"
SRC_URI="https://api.github.com/repos/AcademySoftwareFoundation/OpenImageIO/tarball/v3.1.17.0 -> openimageio-3.1.17.0-73bc189.tar.gz"
LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="*"
DOCS=(
	CHANGES.md
	CREDITS.md
	README.md
)
IUSE="dicom ffmpeg gif jpeg2k jpegxl opencv openvdb python qt6 raw +truetype ${CPU_FEATURES[@]%:*}"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RDEPEND=">=dev-cpp/robin-map-1.2.0
	>=dev-libs/imath-3.1:=
	>=dev-libs/libfmt-7:=
	>=dev-libs/pugixml-1.8:=
	>=media-libs/libheif-1.11:=
	>=media-libs/libjpeg-turbo-2.1:=
	>=media-libs/libpng-1.6:0=
	>=media-libs/libwebp-1.1:=
	>=media-libs/opencolorio-2.3:=
	>=media-libs/openexr-3.1:=
	>=media-libs/tiff-4.0:0=
	sys-libs/zlib:=
	dicom? ( >=sci-libs/dcmtk-3.6.1:0= )
	ffmpeg? ( >=media-video/ffmpeg-4.0:= )
	gif? ( >=media-libs/giflib-5.0:0= )
	jpeg2k? (
	  >=media-libs/openjpeg-2.0:2=
	  >=media-libs/openjph-0.21.2:0=
	)
	jpegxl? ( >=media-libs/libjxl-0.10.1:= )
	opencv? ( >=media-libs/opencv-4.0:= )
	openvdb? (
	  >=dev-cpp/tbb-2017:=
	  >=media-gfx/openvdb-9.0:=
	)
	python? (
	  ${PYTHON_DEPS}
	  $(python_gen_cond_dep '
	    dev-python/numpy[${PYTHON_USEDEP}]
	    >=dev-python/pybind11-2.7[${PYTHON_USEDEP}]
	  ')
	)
	qt6? (
	  dev-qt/qtbase:6[gui]
	  virtual/opengl
	)
	raw? ( >=media-libs/libraw-0.20:= )
	truetype? ( >=media-libs/freetype-2.10:2= )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv AcademySoftwareFoundation-OpenImageIO-* ${S}
}


pkg_setup() {
	use python && python-single-r1_pkg_setup
}
src_configure() {
	# Build with SIMD support
	local cpufeature
	local mysimd=()
	for cpufeature in "${CPU_FEATURES[@]}"; do
	  use "${cpufeature%:*}" && mysimd+=("${cpufeature#*:}")
	done
	 append-ldflags -pthread
	 # If no CPU SIMDs were used, completely disable them
	[[ -z ${mysimd} ]] && mysimd=("0")
	 local mycmakeargs=(
	  -DVERBOSE=ON
	  -DCMAKE_CXX_STANDARD=17
	  -DOIIO_BUILD_TESTS=OFF
	  -DOIIO_BUILD_TOOLS=ON
	  -DBUILD_DOCS=OFF
	  -DINSTALL_DOCS=OFF
	  -DINSTALL_FONTS=$(usex truetype)
	  -DSTOP_ON_WARNING=OFF
	  -DUSE_CCACHE=OFF
	  -DUSE_EXTERNAL_PUGIXML=ON
	  -DUSE_SIMD=$(local IFS=','; echo "${mysimd[*]}")
	  -DENABLE_DCMTK=$(usex dicom)
	  -DENABLE_FFmpeg=$(usex ffmpeg)
	  -DENABLE_Freetype=$(usex truetype)
	  -DENABLE_GIF=$(usex gif)
	  -DENABLE_LibRaw=$(usex raw)
	  -DENABLE_OpenCV=$(usex opencv)
	  -DENABLE_OpenJPEG=$(usex jpeg2k)
	  -DENABLE_OpenVDB=$(usex openvdb)
	  -DENABLE_TBB=$(usex openvdb)
	  -DUSE_JXL=$(usex jpegxl)
	  -DUSE_NUKE=OFF
	  -DUSE_OPENJPH=$(usex jpeg2k)
	  -DUSE_PTEX=OFF
	  -DUSE_PYTHON=$(usex python)
	  -DUSE_QT=$(usex qt6)
	  -DUSE_R3DSDK=OFF
	  -DDISABLE_libuhdr=ON
	)
	 if use python; then
	  mycmakeargs+=(
	    -DPYTHON_VERSION="${EPYTHON#python}"
	    -DPYTHON_SITE_DIR="$(python_get_sitedir)"
	    -DPython3_EXECUTABLE="${PYTHON}"
	  )
	fi
	 cmake_src_configure
}
src_install() {
	# for font install
	cmake_src_install
}



# vim: filetype=ebuild
