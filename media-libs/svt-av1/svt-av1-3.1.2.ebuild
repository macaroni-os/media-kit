# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="AV1 encoder"
HOMEPAGE="https://gitlab.com/AOMediaCodec/SVT-AV1"
SRC_URI="https://gitlab.com/AOMediaCodec/SVT-AV1/-/archive/v3.1.2/SVT-AV1-v3.1.2.tar.bz2 -> SVT-AV1-v3.1.2.tar.bz2"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="*"
BDEPEND="dev-lang/yasm
	
"
S="${WORKDIR}/SVT-AV1-v3.1.2"
src_prepare() {
	# Unused project that triggers the cmake eclasses minimum required cmake check
	rm -rf gstreamer-plugin || die
	cmake_src_prepare
	# Lets not install tests
	sed -e '/install(/d' -i test/CMakeLists.txt || die
}
src_configure() {
	local mycmakeargs=(
	  -DBUILD_TESTING=OFF
	  -DCMAKE_OUTPUT_DIRECTORY="${BUILD_DIR}"
	)
	cmake_src_configure
}


# vim: filetype=ebuild
