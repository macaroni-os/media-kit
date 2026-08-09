# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="High-quality QR Code generator library for C and C++"
HOMEPAGE="https://www.nayuki.io/page/qr-code-generator-library"
SRC_URI="
https://github.com/nayuki/QR-Code-generator/archive/refs/tags/v1.8.0.tar.gz -> QR-Code-generator-1.8.0.tar.gz
https://github.com/EasyCoding/qrcodegen-cmake/archive/refs/tags/v1.8.0-cmake5.tar.gz -> qrcodegen-cmake-v1.8.0-cmake5.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
S="${WORKDIR}/QR-Code-generator-1.8.0"

post_src_unpack() {
	mv EasyCoding-qrcodegen-cmake-* ${S}
}


post_src_unpack() {
	cp -r "${WORKDIR}"/qrcodegen-cmake-*/cmake "${S}"/ || die
	cp "${WORKDIR}"/qrcodegen-cmake-*/CMakeLists.txt "${S}"/ || die
}

src_configure() {
	local mycmakeargs=(
	  -DBUILD_SHARED_LIBS=ON
	  -DQRCODEGEN_BUILD_EXAMPLES=OFF
	  -DQRCODEGEN_BUILD_TESTS=OFF
	)
	 cmake_src_configure
}



# vim: filetype=ebuild
