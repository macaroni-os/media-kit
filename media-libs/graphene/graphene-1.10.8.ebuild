# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit xdg-utils meson python-any-r1

DESCRIPTION="A thin layer of graphic data types"
HOMEPAGE="http://ebassi.github.io/graphene"
SRC_URI="https://api.github.com/repos/ebassi/graphene/tarball/1.10.8 -> graphene-1.10.8-4e25784.tar.gz"
LICENSE="NOASSERTION"
SLOT="0"
KEYWORDS="*"
IUSE="cpu_flags_arm_neon cpu_flags_x86_sse2 doc +introspection"
BDEPEND="${PYTHON_DEPS}
	doc? (
	  dev-util/gtk-doc
	  app-text/docbook-xml-dtd:4.3
	)
	virtual/pkgconfig
	
"
RDEPEND="dev-libs/glib:2
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"

post_src_unpack() {
	mv ebassi-graphene-* ${S}
}


src_prepare() {
	xdg_environment_reset
	default
}
src_configure() {
	local emesonargs=(
	  -Dgtk_doc=$(usex doc true false)
	  -Dgobject_types=true
	  -Dgcc_vector=true
	  -Dtests=false
	  $(meson_use cpu_flags_x86_sse2 sse2)
	  $(meson_use cpu_flags_arm_neon arm_neon)
	  $(meson_feature introspection)
	  -Dinstalled_tests=false
	)
	meson_src_configure
}



# vim: filetype=ebuild
