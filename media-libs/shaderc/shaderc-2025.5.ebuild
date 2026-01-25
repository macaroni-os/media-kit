# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit cmake python-any-r1

DESCRIPTION="A collection of tools, libraries, and tests for Vulkan shader compilation."
HOMEPAGE="https://github.com/google/shaderc"
SRC_URI="https://api.github.com/repos/google/shaderc/tarball/refs/tags/v2025.5 -> shaderc-2025.5-c4b0af6.tar.gz"
LICENSE="NOASSERTION"
SLOT="0"
KEYWORDS="*"
RDEPEND="dev-util/glslang
	dev-util/spirv-tools
	
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-util/spirv-headers
	
"

post_src_unpack() {
	mv google-shaderc-* ${S}
}


src_prepare() {
# Disable third party dependencies
sed -i -e '/add_subdirectory(third_party)/d' CMakeLists.txt
# Fix glslc test generation depending on third-party SPIRV-tool
sed -i -e "s|\$<TARGET_FILE:spirv-dis>|spirv-dis|" \
  glslc/test/CMakeLists.txt || die
# Disable git versioning
sed -i -e '/build-version/d' glslc/CMakeLists.txt || die
# Manually create build-version.inc as we disabled git versioning
cat <<- EOF > glslc/src/build-version.inc || die
  "${P}\n"
  "$(best_version dev-util/spirv-tools)\n"
  "$(best_version dev-util/glslang)\n"
EOF
cmake_src_prepare
}
src_configure() {
  local mycmakeargs=(
    -DSHADERC_SKIP_TESTS="true"
    -DSHADERC_ENABLE_WERROR_COMPILE="false"
    -DSHADERC_ENABLE_EXAMPLES=OFF
    -Dglslang_SOURCE_DIR=/usr/include/glslang
  )
  cmake_src_configure
}



# vim: filetype=ebuild
