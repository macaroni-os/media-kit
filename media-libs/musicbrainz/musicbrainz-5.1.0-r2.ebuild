# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="MusicBrainz Client Library"
HOMEPAGE="http://musicbrainz.org/doc/libmusicbrainz"
SRC_URI="https://github.com/metabrainz/libmusicbrainz/releases/download/release-5.1.0/libmusicbrainz-5.1.0.tar.gz -> musicbrainz-5.1.0-2adc507.tar.gz"
LICENSE="LGPL-2.1"
SLOT="5/1"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/musicbrainz-5.1.0-no-wildcards.patch"
	"${FILESDIR}/musicbrainz-5.1.0-libxml2-2.12.patch"
	"${FILESDIR}/musicbrainz-5.1.0-libxml2-2.12-compat.patch"
)
IUSE="examples"
RDEPEND="dev-libs/libxml2:=
	net-libs/neon
	
"
DEPEND="${RDEPEND}
"
S="${WORKDIR}/libmusicbrainz-5.1.0"
src_install() {
	cmake_src_install
	if use examples; then
	  docinto examples
	  dodoc examples/*.{c,cc,txt}
	  docompress -x /usr/share/doc/musicbrainz-5.1.0/examples
	fi
}


# vim: filetype=ebuild
