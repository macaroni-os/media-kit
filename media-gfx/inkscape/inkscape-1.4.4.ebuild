# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
PYTHON_COMPAT=( python3+ )
inherit cmake flag-o-matic xdg toolchain-funcs python-single-r1

DESCRIPTION="SVG based generic vector-drawing program"
HOMEPAGE="https://inkscape.org/ https://gitlab.com/inkscape/inkscape/"
SRC_URI="https://inkscape.org/gallery/item/59505/inkscape-1.4.4.tar.xz -> inkscape-1.4.4.tar.xz"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE="cdr dia exif graphicsmagick imagemagick inkjar jemalloc jpeg nls
openmp postscript readline spell svg2 visio wpg X
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
# Commons depends
CDEPEND="${PYTHON_DEPS}
	app-text/poppler[cairo]
	dev-cpp/cairomm:0
	dev-cpp/glibmm
	dev-cpp/gtkmm:3.0
	dev-cpp/pangomm
	dev-libs/boehm-gc
	dev-libs/boost:=[stacktrace]
	dev-libs/double-conversion:=
	dev-libs/glib
	dev-libs/libsigc++:2
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/gdl:3
	dev-libs/popt
	media-gfx/potrace
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/lcms:2
	media-libs/libpng:0=
	net-libs/libsoup:2.4
	sci-libs/gsl:=
	x11-libs/pango
	x11-libs/gtk+:3[X?]
	X? ( x11-libs/libX11 )
	$(python_gen_cond_dep '
	  dev-python/appdirs[${PYTHON_USEDEP}]
	  dev-python/cachecontrol[${PYTHON_USEDEP}]
	  dev-python/cssselect[${PYTHON_USEDEP}]
	  dev-python/filelock[${PYTHON_USEDEP}]
	  dev-python/lxml[${PYTHON_USEDEP}]
	  dev-python/pygobject[${PYTHON_USEDEP}]
	  media-gfx/scour[${PYTHON_USEDEP}]
	')
	cdr? (
	  app-text/libwpg:0.3
	  dev-libs/librevenge
	  media-libs/libcdr
	)
	exif? ( media-libs/libexif )
	imagemagick? (
	  !graphicsmagick? ( media-gfx/imagemagick:=[cxx] )
	  graphicsmagick? ( media-gfx/graphicsmagick:=[cxx] )
	)
	jemalloc? ( dev-libs/jemalloc )
	jpeg? ( media-libs/libjpeg-turbo:= )
	readline? ( sys-libs/readline:= )
	spell? ( app-text/gspell )
	visio? (
	  app-text/libwpg
	  dev-libs/librevenge
	  media-libs/libvisio
	)
	wpg? (
	  app-text/libwpg
	  dev-libs/librevenge
	)
	
"
BDEPEND="dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	$(python_gen_cond_dep '
	  dev-python/numpy[${PYTHON_USEDEP}]
	')
	dia? ( app-office/dia )
	postscript? ( app-text/ghostscript-gpl )
	
"
DEPEND="${CDEPEND}
"
pkg_pretend() {
	use openmp && tc-check-openmp
}
pkg_setup() {
	use openmp && tc-check-openmp
	python-single-r1_pkg_setup
}

src_unpack() {
	default
	[[ -d "${S}" ]] || mv -v "${WORKDIR}/${P}_202"?-??-* "${S}" || die
}

src_prepare() {
	cmake_src_prepare
	sed -i "/install.*COPYING/d" CMakeScripts/ConfigCPack.cmake || die
}
src_configure() {
	# aliasing unsafe wrt #310393
	append-flags -fno-strict-aliasing
	local mycmakeargs=(
	  # -DWITH_LPETOOL   # Compile with LPE Tool and experimental LPEs enabled
	  -DWITH_NLS=ON
	  -DENABLE_POPPLER=ON
	  -DENABLE_POPPLER_CAIRO=ON
	  -DWITH_PROFILING=OFF
	  -DWITH_INTERNAL_2GEOM=ON
	  -DBUILD_TESTING=OFF
	  -DWITH_LIBCDR=$(usex cdr)
	  -DWITH_IMAGE_MAGICK=$(usex imagemagick $(usex !graphicsmagick)) # requires ImageMagick 6, only IM must be enabled
	  -DWITH_GRAPHICS_MAGICK=$(usex graphicsmagick $(usex imagemagick)) # both must be enabled to use GraphicsMagick
	  -DWITH_GNU_READLINE=$(usex readline)
	  -DWITH_GSPELL=$(usex spell)
	  -DWITH_JEMALLOC=$(usex jemalloc)
	  -DENABLE_LCMS=ON
	  -DWITH_OPENMP=$(usex openmp)
	  -DBUILD_SHARED_LIBS=ON
	  -DWITH_SVG2=$(usex svg2)
	  -DWITH_LIBVISIO=$(usex visio)
	  -DWITH_LIBWPG=$(usex wpg)
	  -DWITH_X11=$(usex X)
	  -DWITH_NLS=$(usex nls)
	)
	cmake_src_configure
}
src_install() {
	cmake_src_install
	find "${ED}" -type f -name "*.la" -delete || die
	find "${ED}"/usr/share/man -type f -maxdepth 3 -name '*.bz2' -exec bzip2 -d {} \; || die
	find "${ED}"/usr/share/man -type f -maxdepth 3 -name '*.gz' -exec gzip -d {} \; || die
	local extdir="${ED}"/usr/share/${PN}/extensions
	if [[ -e "${extdir}" ]] && [[ -n $(find "${extdir}" -mindepth 1) ]]; then
	  python_optimize "${ED}"/usr/share/${PN}/extensions
	fi
}


# vim: filetype=ebuild
