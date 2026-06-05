# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools toolchain-funcs

DESCRIPTION="A small fast portable speech synthesis system"
HOMEPAGE="https://github.com/festvox/flite"
SRC_URI="
https://github.com/festvox/flite/archive/v2.2.tar.gz -> flite-2.2.tar.gz
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_ben_rm.flitevox -> 2.3-cmu_indic_ben_rm.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_guj_ad.flitevox -> 2.3-cmu_indic_guj_ad.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_guj_dp.flitevox -> 2.3-cmu_indic_guj_dp.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_guj_kt.flitevox -> 2.3-cmu_indic_guj_kt.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_hin_ab.flitevox -> 2.3-cmu_indic_hin_ab.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_kan_plv.flitevox -> 2.3-cmu_indic_kan_plv.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_mar_aup.flitevox -> 2.3-cmu_indic_mar_aup.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_mar_slp.flitevox -> 2.3-cmu_indic_mar_slp.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_pan_amp.flitevox -> 2.3-cmu_indic_pan_amp.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_tam_sdr.flitevox -> 2.3-cmu_indic_tam_sdr.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_tel_kpn.flitevox -> 2.3-cmu_indic_tel_kpn.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_tel_sk.flitevox -> 2.3-cmu_indic_tel_sk.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_indic_tel_ss.flitevox -> 2.3-cmu_indic_tel_ss.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_aew.flitevox -> 2.3-cmu_us_aew.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_ahw.flitevox -> 2.3-cmu_us_ahw.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_aup.flitevox -> 2.3-cmu_us_aup.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_awb.flitevox -> 2.3-cmu_us_awb.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_axb.flitevox -> 2.3-cmu_us_axb.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_bdl.flitevox -> 2.3-cmu_us_bdl.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_clb.flitevox -> 2.3-cmu_us_clb.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_eey.flitevox -> 2.3-cmu_us_eey.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_fem.flitevox -> 2.3-cmu_us_fem.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_gka.flitevox -> 2.3-cmu_us_gka.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_jmk.flitevox -> 2.3-cmu_us_jmk.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_ksp.flitevox -> 2.3-cmu_us_ksp.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_ljm.flitevox -> 2.3-cmu_us_ljm.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_lnh.flitevox -> 2.3-cmu_us_lnh.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_rms.flitevox -> 2.3-cmu_us_rms.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_rxr.flitevox -> 2.3-cmu_us_rxr.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_slp.flitevox -> 2.3-cmu_us_slp.flitevox )
voices? ( http://www.festvox.org/flite/packed/flite-2.3/voices/cmu_us_slt.flitevox -> 2.3-cmu_us_slt.flitevox )"
LICENSE="BSD freetts public-domain regexp-UofT BSD-2"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/flite-1.4-audio-interface.patch"
	"${FILESDIR}/flite-2.2-backport-pr30.patch"
	"${FILESDIR}/flite-2.2-make-4.4.patch"
	"${FILESDIR}/flite-2.2-backport-pr66.patch"
	"${FILESDIR}/flite-2.2-remove-const-cast.patch"
	"${FILESDIR}/flite-2.2-no-native-ar.patch"
)
IUSE="alsa oss pulseaudio voices"
RDEPEND="pulseaudio? (
	  media-sound/pulseaudio
	)
	!pulseaudio? (
	  alsa? (
	    media-libs/alsa-lib
	  )
	)
	
"
DEPEND="${RDEPEND}
"
get_audio() {
	if use pulseaudio; then
	  echo pulseaudio
	elif use alsa; then
	  echo alsa
	elif use oss; then
	  echo oss
	else
	  echo none
	fi
}
src_unpack() {
	for file in ${A}; do
	  case "${file}" in
	    *.flitevox)
	      cp -av "${DISTDIR}/${file}" "${WORKDIR}/${file/*-/}" || die "Unable to copy ${file}"
	      ;;
	    *)
	      unpack "${file}"
	      ;;
	  esac
	done
}
src_prepare() {
	default
	sed -i main/Makefile \
	  -e '/-rpath/s|$(LIBDIR)|$(INSTALLLIBDIR)|g' \
	  || die
	mv configure.{in,ac} || die
	eautoreconf
}
src_configure() {
	local myconf=(
	  --enable-shared
	  --with-audio=$(get_audio)
	)
	econf "${myconf[@]}"
}
src_compile() {
	emake -j1 CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}
src_install() {
	default
	dodoc ACKNOWLEDGEMENTS README.md
	rm -rf "${D}"/usr/lib*/*.a
	if use voices; then
	  insinto /usr/share/flite
	  doins "${WORKDIR}"/*.flitevox
	fi
}


# vim: filetype=ebuild
