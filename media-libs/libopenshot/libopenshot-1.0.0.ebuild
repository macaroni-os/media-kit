# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit cmake python-single-r1 toolchain-funcs

DESCRIPTION="OpenShot Video Library (libopenshot) is a free, open-source project dedicated to delivering high quality video editing, animation, and playback solutions to the world. API currently supports C++, Python, and Ruby."
HOMEPAGE="http://www.openshot.org"
SRC_URI="https://api.github.com/repos/OpenShot/libopenshot/tarball/v1.0.0 -> libopenshot-1.0.0-732f182.tar.gz"
LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/libopenshot-guard-trackedobjectbbox-without-opencv.patch"
)
IUSE="babl doc examples +imagemagick +opencv +pipewire +python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
BDEPEND="virtual/pkgconfig
	doc? ( app-doc/doxygen )
	python? ( >=dev-lang/swig-3.0 )
	
"
RDEPEND="dev-libs/jsoncpp:0=
	dev-qt/qtbase:6[gui]
	dev-qt/qtsvg:6
	>=media-libs/libopenshot-audio-1.0.0:0=
	media-video/ffmpeg:0[encode,x264,xvid,vpx,mp3,theora,vorbis]
	net-libs/cppzmq
	net-libs/zeromq
	babl? ( media-libs/babl )
	imagemagick? ( >=media-gfx/imagemagick-7:0=[cxx] )
	opencv? (
	  >=media-libs/opencv-4.5.2:=[contrib]
	  dev-libs/protobuf:=
	)
	pipewire? (
	  dev-libs/glib:2
	  media-video/pipewire
	  sys-apps/xdg-desktop-portal
	)
	python? ( ${PYTHON_DEPS} )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv OpenShot-libopenshot-* ${S}
}


pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && tc-check-openmp
}
pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && tc-check-openmp
	use python && python-single-r1_pkg_setup
}
src_configure() {
	local mycmakeargs=(
	  -DBUILD_TESTING=OFF
	  -DDISABLE_BUNDLED_JSONCPP=ON
	  -DUSE_SYSTEM_JSONCPP=ON
	  -DUSE_HW_ACCEL=ON
	  -DUSE_QT6=ON
	  -DENABLE_LIB_DOCS=$(usex doc)
	  -DENABLE_MAGICK=$(usex imagemagick)
	  -DENABLE_OPENCV=$(usex opencv)
	  -DENABLE_WAYLAND_CAPTURE=$(usex pipewire)
	  -DENABLE_VULKAN_BENCHMARK=OFF
	  -DENABLE_PYTHON=$(usex python)
	  -DENABLE_RUBY=OFF # TODO: add ruby support
	  -DENABLE_JAVA=OFF
	  -DENABLE_GODOT=OFF
	  -DCMAKE_DISABLE_FIND_PACKAGE_Resvg=ON
	  $(cmake_use_find_package imagemagick ImageMagick)
	  $(cmake_use_find_package babl babl)
	)
	use python && mycmakeargs+=(
	  -DPYTHON_EXECUTABLE="${PYTHON}"
	  -DPYTHON_INCLUDE_DIR="$(python_get_includedir)"
	  -DPYTHON_LIBRARY="$(python_get_library_path)"
	  -DPYTHON_MODULE_PATH="$(python_get_sitedir)"
	)
	cmake_src_configure
}
src_compile() {
	cmake_src_compile
	use doc && cmake_build doc
}
src_install() {
	local DOCS=( AUTHORS README.md doc/HW-ACCEL.md )
	 cmake_src_install
	 use examples && dodoc examples/Example*.{cpp,py,rb}
	use python && python_optimize
}



# vim: filetype=ebuild
