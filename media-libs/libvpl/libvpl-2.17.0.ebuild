# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="Intel Video Processing Library dispatcher and API headers"
HOMEPAGE="https://github.com/intel/libvpl"
SRC_URI="https://api.github.com/repos/intel/libvpl/tarball/v2.17.0 -> libvpl-2.17.0-d77f919.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"

post_src_unpack() {
	mv intel-libvpl-* ${S}
}


src_configure() {
	local mycmakeargs=(
	  -DBUILD_SHARED_LIBS=ON
	  -DBUILD_EXAMPLES=OFF
	  -DINSTALL_EXAMPLES=OFF
	  -DBUILD_EXPERIMENTAL=ON
	  -DBUILD_TESTS=OFF
	  -DENABLE_LIBDIR_IN_RUNTIME_SEARCH=OFF
	  -DINSTALL_DEV=ON
	  -DINSTALL_LIB=ON
	  -DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
	)
	 cmake_src_configure
}



# vim: filetype=ebuild
