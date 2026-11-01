# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="Open Source API and interchange format for editorial timeline information."
HOMEPAGE="http://opentimeline.io"
SRC_URI="
https://api.github.com/repos/AcademySoftwareFoundation/OpenTimelineIO/tarball/v0.18.1 -> opentimelineio-0.18.1.tar.gz
https://github.com/Tencent/rapidjson/archive/24b5e7a8b27f42fa16b96fc70aade9106cf7102f.tar.gz -> rapidjson-24b5e7a8b27f42fa16b96fc70aade9106cf7102f.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
DOCS=(
	README.md
)
RDEPEND="dev-libs/imath:=
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv AcademySoftwareFoundation-OpenTimelineIO-* ${S}
}


src_prepare() {
	mv -T "${WORKDIR}"/rapidjson-24b5e7a8b27f42fa16b96fc70aade9106cf7102f src/deps/rapidjson || die
	sed -e "s|\(set(OTIO_RESOLVED_CXX_DYLIB_INSTALL_DIR \"\${CMAKE_INSTALL_PREFIX}/\)lib\")|\1$(get_libdir)\")|" \
	  -i CMakeLists.txt || die
	sed -e "s|share/opentime|$(get_libdir)/cmake/opentime|g" \
	  -i src/opentime{,lineio}/CMakeLists.txt || die
	cmake_src_prepare
}
src_configure() {
	local mycmakeargs=(
	  -DBUILD_TESTING=no
	  -DOTIO_AUTOMATIC_SUBMODULES=no
	  -DOTIO_FIND_IMATH=yes
	  -DOTIO_FIND_RAPIDJSON=no
	  -DOTIO_SHARED_LIBS=yes
	  -DOTIO_CXX_COVERAGE=no
	  -DOTIO_CXX_EXAMPLES=no
	  -DOTIO_CXX_INSTALL=yes
	  -DOTIO_DEPENDENCIES_INSTALL=no
	  -DOTIO_PYTHON_INSTALL=no
	)
	cmake_src_configure
}



# vim: filetype=ebuild
