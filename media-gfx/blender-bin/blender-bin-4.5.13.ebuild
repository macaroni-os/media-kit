# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
QA_PREBUILT="*"
inherit desktop xdg

DESCRIPTION="3D Creation/Animation/Publishing System"
HOMEPAGE="http://www.blender.org/"
SRC_URI="https://download.blender.org/release/Blender4.5/blender-4.5.13-linux-x64.tar.xz -> blender-4.5.13-linux-x64.tar.xz"
LICENSE="|| ( GPL-2 BL )"
SLOT="0"
KEYWORDS="*"
RESTRICT="bindist strip"
DEPEND="sys-libs/ncurses[tinfo]
"
S="${WORKDIR}/blender-${PV}-linux-x64"
src_prepare() {
	default
	sed -e "s|Name=Blender|Name=Blender-bin ${PV}|" \
		-e "s|Exec=blender|Exec=blender-bin|" \
		-e "s|Icon=blender|Icon=blender-bin|" \
		-i ${S}/blender.desktop || die
	mv ${S}/blender.desktop ${S}/blender-bin.desktop
}
src_install() {
	dodir /opt/blender
	cp -pPR ${S}/* ${D}/opt/blender || die "Failed to copy files"
	fperms +x /opt/blender/blender
	domenu ${S}/blender-bin.desktop
	newicon -s scalable ${S}/blender.svg blender-bin.svg
	dosym ../blender/blender /opt/bin/${PN}
}


# vim: filetype=ebuild
