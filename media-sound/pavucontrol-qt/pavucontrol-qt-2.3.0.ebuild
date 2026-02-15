# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="A Pulseaudio mixer in Qt (port of pavucontrol)"
HOMEPAGE="https://lxqt.github.io"
SRC_URI="https://api.github.com/repos/lxqt/pavucontrol-qt/tarball/2.3.0 -> pavucontrol-qt-2.3.0-5b280a4.tar.gz"
LICENSE="GPL-2 GPL-2+"
SLOT="0"
KEYWORDS="*"
RDEPEND="dev-libs/glib:2
	dev-qt/qtbase:6[gui]
	media-libs/libpulse[glib]
	
"
DEPEND="${RDEPEND}
	dev-util/lxqt-build-tools
	dev-qt/qttools:6[linguist]
	virtual/pkgconfig
	
"

post_src_unpack() {
	mv lxqt-pavucontrol-qt-* ${S}
}



# vim: filetype=ebuild
