# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
PYTHON_REQ_USE="xml"
inherit meson python-any-r1

DESCRIPTION="Reusable library for GPU-accelerated image processing primitives"
HOMEPAGE="https://code.videolan.org/videolan/libplacebo"
SRC_URI="
https://api.github.com/repos/haasn/libplacebo/tarball/v7.351.0 -> libplacebo-7.351.0.tar.gz
https://github.com/Dav1dde/glad/archive/525eddb7e04bc4008b691fb38a6d31bf3cad684c.tar.gz -> libplacebo-7.351.0-glad-525eddb7e04bc4008b691fb38a6d31bf3cad684c.tar.gz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="glslang lcms +opengl +shaderc +vulkan"
BDEPEND="virtual/pkgconfig
	vulkan? (
	  ${PYTHON_DEPS}
	  $(python_gen_any_dep 'dev-python/mako[${PYTHON_USEDEP}]')
	)
	
"
RDEPEND="glslang? ( dev-util/glslang )
	lcms? ( media-libs/lcms:2 )
	opengl? ( media-libs/libepoxy )
	shaderc? ( media-libs/shaderc )
	vulkan? (
	  dev-util/vulkan-headers
	  media-libs/vulkan-loader
	)
	
"
DEPEND="${RDEPEND}
"
post_src_unpack() {
	mv haasn-libplacebo-* ${S}
	if use opengl ; then
	  rmdir "${S}"/3rdparty/glad || die
	  mv glad-525eddb7e04bc4008b691fb38a6d31bf3cad684c "${S}"/3rdparty/glad || die
	fi
	sed -i "s:\(#include <vulkan/vulkan.h>\):\1\n#include <vulkan/vulkan_metal.h>:" "${S}"/src/include/${PN}/vulkan.h || die
}
python_check_deps() {
	has_version -b "dev-python/mako[${PYTHON_USEDEP}]"
}
pkg_setup() {
	use vulkan && python-any-r1_pkg_setup
}
src_configure() {
	local emesonargs=(
	  $(meson_feature glslang)
	  $(meson_feature lcms)
	  $(meson_feature opengl)
	  $(meson_feature shaderc)
	  $(meson_feature vulkan)
	  -Dtests=false
	  # hard-code path from dev-util/vulkan-headers
	  -Dvulkan-registry=/usr/share/vulkan/registry/vk.xml
	)
	meson_src_configure
}


# vim: filetype=ebuild
