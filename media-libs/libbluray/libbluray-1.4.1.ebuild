# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson java-pkg-opt-2

DESCRIPTION="Blu-ray playback libraries"
HOMEPAGE="https://www.videolan.org/developers/libbluray.html"
SRC_URI="https://download.videolan.org/pub/videolan/libbluray/1.4.1/libbluray-1.4.1.tar.xz -> libbluray-1.4.1.tar.xz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="aacs bdplus cli +fontconfig java +truetype utils +xml"
BDEPEND="virtual/pkgconfig
	java? (
	  dev-java/ant-bin
	  virtual/jdk
	)
	
"
RDEPEND="dev-libs/libudfread
	aacs? ( media-libs/libaccs )
	bdplus? ( media-libs/libbdplus )
	fontconfig? ( media-libs/fontconfig )
	java? ( virtual/jre )
	truetype? ( media-libs/freetype:2 )
	xml? ( dev-libs/libxml2 )
	
"
DEPEND="${RDEPEND}
	
"
src_configure() {
	use java || unset JDK_HOME
	local emesonargs=(
	  $(meson_use utils enable_examples)
	  $(meson_use cli enable_tools)
	  -Denable_devtools=false
	  $(meson_feature java bdj_jar)
	  $(meson_feature truetype freetype)
	  $(meson_feature xml libxml2)
	  $(meson_feature fontconfig)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	use utils &&
	  find .libs/ -type f -executable ! -name "${PN}.*" \
	     $(use java || echo '! -name bdj_test') -exec dobin {} +
	use java && java-pkg_regjar "${ED}"/usr/share/${PN}/lib/*.jar
	einstalldocs
	find "${ED}" -name '*.la' -delete || die
}


# vim: filetype=ebuild
