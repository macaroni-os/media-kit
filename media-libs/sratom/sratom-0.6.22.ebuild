# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="Library for serialising LV2 atoms to and from RDF"
HOMEPAGE="https://drobilla.net/software/sratom"
SRC_URI="https://download.drobilla.net/sratom-0.6.22.tar.xz -> sratom-0.6.22.tar.xz"
LICENSE="ISC"
SLOT="0"
KEYWORDS="*"
DOCS=(
	NEWS
	README.md
)
BDEPEND="virtual/pkgconfig
"
RDEPEND=">=dev-libs/serd-0.30.10
	>=dev-libs/sord-0.16.16
	>=media-libs/lv2-1.18.4
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	local emesonargs=(
		-Ddocs=disabled
		-Dhtml=disabled
		-Dsinglehtml=disabled
		-Dlint=false
		-Dtests=disabled
	)

	meson_src_configure
}


# vim: filetype=ebuild
