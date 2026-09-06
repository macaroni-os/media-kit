# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
CMAKE_BUILD_TYPE=Release
CPU_USE=( x86_{avx,avx2,avx512f,f16c,sse2,sse3,sse4_1,sse4_2,ssse3} )
inherit cmake python-single-r1 virtualx

DESCRIPTION="A color management framework for visual effects and animation."
HOMEPAGE="https://opencolorio.org"
SRC_URI="https://api.github.com/repos/AcademySoftwareFoundation/OpenColorIO/tarball/v2.5.2 -> opencolorio-2.5.2-c52966a.tar.gz"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="*"
IUSE="apps ${CPU_USE[@]/#/cpu_flags_} opengl python"
REQUIRED_USE="apps? ( opengl )
python? ( ${PYTHON_REQUIRED_USE} )
"
BDEPEND="virtual/pkgconfig
"
RDEPEND=">=dev-cpp/pystring-1.1.3
	>=dev-cpp/yaml-cpp-0.8.0:=
	>=dev-libs/expat-2.6.0
	>=dev-libs/imath-3.1.1:=
	>=sys-libs/minizip-ng-4.0.0
	>=sys-libs/zlib-1.2.13
	apps? (
	  >=media-libs/lcms-2.2:2
	  >=media-libs/openexr-3.2.0:=
	)
	opengl? (
	  media-libs/freeglut
	  >=media-libs/glew-2.1.0:=
	  media-libs/glu
	  media-libs/libglvnd
	)
	python? (
	  ${PYTHON_DEPS}
	  $(python_gen_cond_dep '>=dev-python/pybind11-2.9.2[${PYTHON_USEDEP}]')
	)
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv AcademySoftwareFoundation-OpenColorIO-* ${S}
}


pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	cmake_src_prepare
	cmake_run_in tests cmake_comment_add_subdirectory osl
	if use python; then
	  local sitedir=$(python_get_sitedir)
	  sed -i -e "s|^set(PYTHON_VARIANT_PATH .*|set(PYTHON_VARIANT_PATH \"${sitedir}\" CACHE INTERNAL \"\")|" \
	    src/bindings/python/CMakeLists.txt || die
	  grep -q "^set(PYTHON_VARIANT_PATH \"${sitedir}\"" src/bindings/python/CMakeLists.txt \
	    || die "failed to adjust the PyOpenColorIO install path"
	fi
}

src_configure() {
	local mycmakeargs=(
	  -DOCIO_BUILD_APPS=$(usex apps)
	  -DOCIO_BUILD_DOCS=OFF
	  -DOCIO_BUILD_GPU_TESTS=$(usex test)
	  -DOCIO_BUILD_JAVA=OFF
	  -DOCIO_BUILD_NUKE=OFF
	  -DOCIO_BUILD_OPENFX=OFF
	  -DOCIO_BUILD_PYTHON=$(usex python)
	  -DOCIO_BUILD_TESTS=$(usex test)
	  -DOCIO_INSTALL_EXT_PACKAGES=NONE
	  -DOCIO_USE_HEADLESS=OFF
	  -DOCIO_USE_OIIO_FOR_APPS=OFF
	  -DOCIO_USE_SIMD=ON
	)
	if use amd64 || use x86; then
	  mycmakeargs+=(
	    -DOCIO_USE_SSE2=$(usex cpu_flags_x86_sse2)
	    -DOCIO_USE_SSE3=$(usex cpu_flags_x86_sse3)
	    -DOCIO_USE_SSSE3=$(usex cpu_flags_x86_ssse3)
	    -DOCIO_USE_SSE4=$(usex cpu_flags_x86_sse4_1)
	    -DOCIO_USE_SSE42=$(usex cpu_flags_x86_sse4_2)
	    -DOCIO_USE_AVX=$(usex cpu_flags_x86_avx)
	    -DOCIO_USE_AVX2=$(usex cpu_flags_x86_avx2)
	    -DOCIO_USE_AVX512=$(usex cpu_flags_x86_avx512f)
	    -DOCIO_USE_F16C=$(usex cpu_flags_x86_f16c)
	  )
	fi
	if use python; then
	  mycmakeargs+=(
	    -DOCIO_PYTHON_VERSION=${EPYTHON/python/}
	    -DPython_EXECUTABLE="${PYTHON}"
	  )
	fi
	cmake_src_configure
}
src_install() {
	cmake_src_install
	use python && python_optimize
}



# vim: filetype=ebuild
