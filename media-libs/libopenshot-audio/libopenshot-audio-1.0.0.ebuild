# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="OpenShot Audio Library (libopenshot-audio) is a free, open-source project that enables high-quality editing and playback of audio, and is based on the amazing JUCE library."
HOMEPAGE="http://www.openshot.org"
SRC_URI="https://api.github.com/repos/OpenShot/libopenshot-audio/tarball/v1.0.0 -> libopenshot-audio-1.0.0-56930c6.tar.gz"
LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="*"
DOCS=(
	AUTHORS
	INSTALL.md
	README.md
)
IUSE="doc"
BDEPEND="doc? ( app-doc/doxygen )
	
"
RDEPEND="media-libs/alsa-lib
	sys-libs/zlib
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv OpenShot-libopenshot-audio-* ${S}
}


src_configure() {
	local mycmakeargs=(
	  -DENABLE_AUDIO_DOCS=$(usex doc)
	  -DAUTO_INSTALL_DOCS=ON
	)
	cmake_src_configure
}



# vim: filetype=ebuild
