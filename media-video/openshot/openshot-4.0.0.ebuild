# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
PYTHON_REQ_USE=xml
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 xdg

DESCRIPTION="OpenShot Video Editor is an award-winning free and open-source video editor for Linux, Mac, and Windows, and is dedicated to delivering high quality video editing and animation solutions to the world."
HOMEPAGE="http://www.openshot.org"
SRC_URI="https://api.github.com/repos/OpenShot/openshot-qt/tarball/v4.0.0 -> openshot-4.0.0-a653b03.tar.gz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"
IUSE="doc"
BDEPEND="$(python_gen_cond_dep '
	  doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	')
	
"
RDEPEND="$(python_gen_cond_dep '
	  dev-python/defusedxml[${PYTHON_USEDEP}]
	  dev-python/numpy[${PYTHON_USEDEP}]
	  dev-python/pillow[${PYTHON_USEDEP}]
	  dev-python/pyzmq[${PYTHON_USEDEP}]
	  dev-python/requests[${PYTHON_USEDEP}]
	  dev-python/PyQt6[statemachine,${PYTHON_USEDEP}]
	')
	>=media-libs/libopenshot-1.0.0:0=[python,${PYTHON_SINGLE_USEDEP}]
	
"

post_src_unpack() {
	mv OpenShot-openshot-qt-* ${S}
}


src_prepare() {
	distutils-r1_python_prepare_all
	sed -i 's/^ROOT =.*/ROOT = False/' setup.py || die
}
python_compile_all() {
	use doc && emake -C doc html
}
python_install_all() {
	use doc && local HTML_DOCS=( doc/_build/html/. )
	distutils-r1_python_install_all
}



# vim: filetype=ebuild
