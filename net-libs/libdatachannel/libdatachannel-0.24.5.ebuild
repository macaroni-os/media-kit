# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="C/C++ WebRTC network library featuring Data Channels, Media Transport, and WebSockets"
HOMEPAGE="https://github.com/paullouisageneau/libdatachannel"
SRC_URI="
https://api.github.com/repos/paullouisageneau/libdatachannel/tarball/v0.24.5 -> libdatachannel-0.24.5-443f693.tar.gz
mirror://macaroni/libdatachannel-0.24.5-mark-gitsubmodules-bundle-443f693.tar.xz -> libdatachannel-0.24.5-mark-gitsubmodules-bundle-443f693.tar.xz"
LICENSE="MPL-2.0 BSD MIT"
SLOT="0"
KEYWORDS="*"
IUSE="gnutls +media +websocket"
RDEPEND="gnutls? (
	    dev-libs/nettle:=
	    net-libs/gnutls:=
	)
	!gnutls? ( dev-libs/openssl:= )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv paullouisageneau-libdatachannel-* ${S}
}


post_src_unpack() {
	local d main_dir bundle_dir
	for d in "${WORKDIR}"/paullouisageneau-libdatachannel-*; do
	  if [[ -f ${d}/CMakeLists.txt ]]; then
	    main_dir=${d}
	  else
	    bundle_dir=${d}
	  fi
	done
	 [[ -n ${main_dir} ]] || die "could not locate main libdatachannel source directory"
	 if [[ -n ${bundle_dir} && ${bundle_dir} != "${main_dir}" ]]; then
	  cp -r "${bundle_dir}"/deps/. "${main_dir}"/deps/ || die
	fi
	 mv "${main_dir}" "${S}" || die
}

src_configure() {
	local mycmakeargs=(
	  -DBUILD_SHARED_LIBS=ON
	  -DBUILD_SHARED_DEPS_LIBS=OFF
	  -DNO_EXAMPLES=ON
	  -DNO_MEDIA=$(usex media OFF ON)
	  -DNO_TESTS=ON
	  -DNO_WEBSOCKET=$(usex websocket OFF ON)
	  -DPREFER_SYSTEM_LIB=OFF
	  -DRTC_UPDATE_VERSION_HEADER=OFF
	  -DUSE_GNUTLS=$(usex gnutls)
	  -DUSE_MBEDTLS=OFF
	  -DUSE_NICE=OFF
	  -DWARNINGS_AS_ERRORS=OFF
	)
	 cmake_src_configure
}



# vim: filetype=ebuild
