# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
addr2line-0.14.1
adler-1.0.2
adler32-1.2.0
aho-corasick-0.7.15
ansi_term-0.11.0
aom-sys-0.2.2
arbitrary-0.4.7
arg_enum_proc_macro-0.3.1
arrayvec-0.5.2
assert_cmd-1.0.3
atty-0.2.14
autocfg-1.0.1
av-metrics-0.6.2
backtrace-0.3.56
bindgen-0.56.0
bitflags-1.2.1
bitstream-io-1.0.0
bstr-0.2.15
bumpalo-3.6.1
bytemuck-1.5.1
byteorder-1.4.3
cast-0.2.3
cc-1.0.67
cexpr-0.4.0
cfg-if-0.1.10
cfg-if-1.0.0
chrono-0.4.19
clang-sys-1.1.1
clap-2.33.3
cmake-0.1.45
color_quant-1.1.0
console-0.14.1
console_error_panic_hook-0.1.6
crc32fast-1.2.1
criterion-0.3.4
criterion-plot-0.4.3
crossbeam-0.8.0
crossbeam-channel-0.5.0
crossbeam-deque-0.8.0
crossbeam-epoch-0.9.3
crossbeam-queue-0.3.1
crossbeam-utils-0.8.3
csv-1.1.6
csv-core-0.1.10
ctor-0.1.20
dav1d-sys-0.3.3
dcv-color-primitives-0.1.16
deflate-0.8.6
difference-2.0.0
doc-comment-0.3.3
either-1.6.1
encode_unicode-0.3.6
env_logger-0.8.3
fern-0.6.0
getrandom-0.2.2
gimli-0.23.0
glob-0.3.0
half-1.7.1
heck-0.3.2
hermit-abi-0.1.18
humantime-2.1.0
image-0.23.14
interpolate_name-0.2.3
itertools-0.8.2
itertools-0.9.0
itertools-0.10.0
itoa-0.4.7
jobserver-0.1.21
js-sys-0.3.50
lab-0.8.2
lazy_static-1.4.0
lazycell-1.3.0
libc-0.2.92
libfuzzer-sys-0.3.5
libloading-0.7.0
log-0.4.14
memchr-2.3.4
memoffset-0.6.3
miniz_oxide-0.3.7
miniz_oxide-0.4.4
nasm-rs-0.2.0
nom-5.1.2
noop_proc_macro-0.3.0
num-derive-0.3.3
num-integer-0.1.44
num-iter-0.1.42
num-rational-0.3.2
num-traits-0.2.14
num_cpus-1.13.0
object-0.23.0
oorandom-11.1.3
output_vt100-0.1.2
paste-1.0.5
peeking_take_while-0.1.2
pest-2.1.3
pkg-config-0.3.19
plotters-0.3.0
plotters-backend-0.3.0
plotters-svg-0.3.0
png-0.16.8
ppv-lite86-0.2.10
predicates-1.0.7
predicates-core-1.0.2
predicates-tree-1.0.2
pretty_assertions-0.6.1
proc-macro2-1.0.24
quote-1.0.9
rand-0.8.3
rand_chacha-0.3.0
rand_core-0.6.2
rand_hc-0.3.0
rayon-1.5.0
rayon-core-1.9.0
regex-1.4.5
regex-automata-0.1.9
regex-syntax-0.6.23
rust_hawktracer-0.7.0
rust_hawktracer_normal_macro-0.4.1
rust_hawktracer_proc_macro-0.4.1
rust_hawktracer_sys-0.4.2
rustc-demangle-0.1.18
rustc-hash-1.1.0
rustc_version-0.2.3
rustc_version-0.3.3
ryu-1.0.5
same-file-1.0.6
scan_fmt-0.2.6
scoped-tls-1.0.0
scopeguard-1.1.0
semver-0.9.0
semver-0.11.0
semver-parser-0.7.0
semver-parser-0.10.2
serde-1.0.125
serde_cbor-0.11.1
serde_derive-1.0.125
serde_json-1.0.64
shlex-0.1.1
signal-hook-0.3.7
signal-hook-registry-1.3.0
simd_helpers-0.1.0
strsim-0.8.0
strum-0.20.0
strum_macros-0.20.1
syn-1.0.67
system-deps-2.0.3
termcolor-1.1.2
terminal_size-0.1.16
textwrap-0.11.0
thiserror-1.0.24
thiserror-impl-1.0.24
time-0.1.43
tinytemplate-1.2.1
toml-0.5.8
treeline-0.1.0
ucd-trie-0.1.3
unicode-segmentation-1.7.1
unicode-width-0.1.8
unicode-xid-0.2.1
vec_map-0.8.2
version-compare-0.0.11
version_check-0.9.3
wait-timeout-0.2.0
walkdir-2.3.2
wasi-0.10.2+wasi-snapshot-preview1
wasm-bindgen-0.2.73
wasm-bindgen-backend-0.2.73
wasm-bindgen-futures-0.4.23
wasm-bindgen-macro-0.2.73
wasm-bindgen-macro-support-0.2.73
wasm-bindgen-shared-0.2.73
wasm-bindgen-test-0.3.23
wasm-bindgen-test-macro-0.3.23
web-sys-0.3.50
which-3.1.1
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
y4m-0.7.0

"

inherit cargo

SRC_URI="
	https://api.github.com/repos/xiph/rav1e/tarball/v0.4.1 -> rav1e-0.4.1.tar.gz
	$(cargo_crate_uris ${CRATES})
"
KEYWORDS="*"

DESCRIPTION="The fastest and safest AV1 encoder"
HOMEPAGE="https://github.com/xiph/rav1e"
RESTRICT=""
LICENSE="BSD-2 Apache-2.0 MIT Unlicense"
SLOT="0"

IUSE="+capi"

ASM_DEP=">=dev-lang/nasm-2.15"
BDEPEND="
	amd64? ( ${ASM_DEP} )
	capi? ( dev-util/cargo-c )
"

src_unpack() {
	default
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/xiph-rav1e-* ${S} || die
}

src_compile() {
	export CARGO_HOME="${ECARGO_HOME}"
	local args=$(usex debug "" --release)

	cargo build ${args} \
		|| die "cargo build failed"

	if use capi; then
		cargo cbuild ${args} --target-dir="capi" \
			--prefix="/usr" --libdir="/usr/$(get_libdir)" \
			|| die "cargo cbuild failed"
	fi
}

src_install() {
	export CARGO_HOME="${ECARGO_HOME}"
	local args=$(usex debug --debug "")

	if use capi; then
		cargo cinstall $args --target-dir="capi" \
			--prefix="/usr" --libdir="/usr/$(get_libdir)" --destdir="${ED%/}" \
			|| die "cargo cinstall failed"
	fi

	cargo_src_install
}