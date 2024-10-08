# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils cmake flag-o-matic

DESCRIPTION="Stream based read/write library for COLLADA files"
HOMEPAGE="http://www.opencollada.org/"
SRC_URI="https://api.github.com/repos/KhronosGroup/OpenCOLLADA/tarball/v1.6.68 -> opencollada-1.6.68.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="static-libs"

RDEPEND="
	dev-libs/libpcre:=
	dev-libs/libxml2:=
	dev-libs/zziplib
	media-libs/lib3ds
	sys-libs/zlib
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-admin/chrpath
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/${PN}-1.6.68-fix-null-conversion.patch"
	"${T}/${PN}-cmake-fixes.patch"
	"${FILESDIR}/${PN}-1.6.63-pcre-fix.patch"
)

src_unpack() {
	default
	rm -rf ${S}
	mv "${WORKDIR}"/KhronosGroup-OpenCOLLADA-* "${S}" || die
}

src_prepare() {
	edos2unix CMakeLists.txt

	cp "${FILESDIR}/${PN}-cmake-fixes.patch.template" "${T}/${PN}-cmake-fixes.patch"
	sed -i -e "s/@MAJOR@/$(ver_cut 1)/" \
		-e "s/@MINOR@/$(ver_cut 2)/" \
		-e "s/@PATCH@/$(ver_cut 3)/" "${T}/${PN}-cmake-fixes.patch" || die

	cmake_src_prepare

	# Remove bundled depends that have portage equivalents
	rm -rv Externals/{expat,lib3ds,LibXML,pcre,zziplib} || die

	# Remove unused build systems
	rm -v Makefile scripts/{unixbuild.sh,vcproj2cmake.rb} || die
	find "${S}" -name SConscript -delete || die
}

src_configure() {
	# bug 619670
	append-cxxflags -std=c++14

	local mycmakeargs=(
		-DUSE_SHARED=ON
		-DUSE_STATIC=$(usex static-libs)
		-DUSE_LIBXML=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	newenvd - 99opencollada <<- _EOF_
		LDPATH=/usr/$(get_libdir)/opencollada
	_EOF_

	# Remove insecure DAEValidator RUNPATH and install DAEValidator library
	dolib.so "${BUILD_DIR}/lib/libDAEValidatorLibrary.so"
	chrpath -d "${BUILD_DIR}/bin/DAEValidator" || die

	dobin "${BUILD_DIR}/bin/DAEValidator"
	dobin "${BUILD_DIR}/bin/OpenCOLLADAValidator"
	# Need to be in same directory as above binaries
	docinto "/usr/bin"
	dodoc "${BUILD_DIR}/bin/COLLADAPhysX3Schema.xsd"
	dodoc "${BUILD_DIR}/bin/collada_schema_1_4_1.xsd"
	dodoc "${BUILD_DIR}/bin/collada_schema_1_5.xsd"
}