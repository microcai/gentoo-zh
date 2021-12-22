# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# sed -E '/^name|^version/bn;d;:n;s/^name\s=\s"([0-9a-zA-Z_-]+)"/\1-/;/^version\s/bv;N;s/\n//;:v;s/([0-9a-zA-Z_-]+)version\s=\s"([a-zA-Z0-9\.\+-]+)"/\1\2/' Cargo.lock | xclip
CRATES="
addr2line-0.13.0
adler-0.2.3
aho-corasick-0.7.14
ansi_term-0.11.0
arrayref-0.3.6
arrayvec-0.5.2
atty-0.2.14
autocfg-0.1.7
autocfg-1.0.1
backtrace-0.3.53
base64-0.10.1
base64-0.12.3
bitflags-0.9.1
bitflags-1.2.1
blake2b_simd-0.5.10
block-0.1.6
byteorder-1.3.4
bytes-0.4.12
cc-1.0.61
cfg-if-0.1.10
cfg-if-1.0.0
chrono-0.4.19
clap-2.33.3
clipboard-win-2.2.0
clipboard2-0.1.1
cloudabi-0.0.3
constant_time_eq-0.1.5
cookie-0.12.0
cookie_store-0.7.0
core-foundation-0.7.0
core-foundation-sys-0.7.0
crc32fast-1.2.1
crossbeam-deque-0.7.3
crossbeam-epoch-0.8.2
crossbeam-queue-0.2.3
crossbeam-utils-0.7.2
dbus-0.6.5
dirs-1.0.5
dirs-2.0.2
dirs-sys-0.3.5
dtoa-0.4.6
either-1.6.1
encoding_rs-0.8.24
env_logger-0.7.1
error-chain-0.12.4
failure-0.1.8
failure_derive-0.1.8
flate2-1.0.18
fnv-1.0.7
foreign-types-0.3.2
foreign-types-shared-0.1.1
fuchsia-cprng-0.1.1
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.1.30
futures-cpupool-0.1.8
getrandom-0.1.15
gimli-0.22.0
h2-0.1.26
hashbrown-0.9.1
heck-0.3.1
hermit-abi-0.1.17
htmlescape-0.3.1
http-0.1.21
http-body-0.1.0
httparse-1.3.4
humantime-1.3.0
hyper-0.12.35
hyper-tls-0.3.2
idna-0.1.5
idna-0.2.0
indexmap-1.6.0
iovec-0.1.4
itoa-0.4.6
kernel32-sys-0.2.2
lazy_static-1.4.0
libc-0.2.80
libdbus-sys-0.2.1
lock_api-0.3.4
log-0.4.11
mac-notification-sys-0.3.0
malloc_buf-0.0.6
matches-0.1.8
maybe-uninit-2.0.0
memchr-2.3.3
memoffset-0.5.6
mime-0.3.16
mime_guess-2.0.3
miniz_oxide-0.4.3
mio-0.6.22
miow-0.2.1
native-tls-0.2.4
net2-0.2.35
nix-0.14.1
notify-rust-3.6.3
num-integer-0.1.43
num-traits-0.2.12
num_cpus-1.13.0
objc-0.2.7
objc-foundation-0.1.1
objc_id-0.1.1
object-0.21.1
openssl-0.10.30
openssl-probe-0.1.2
openssl-sys-0.9.58
parking_lot-0.9.0
parking_lot_core-0.6.2
percent-encoding-1.0.1
percent-encoding-2.1.0
pkg-config-0.3.19
ppv-lite86-0.2.9
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.24
publicsuffix-1.5.4
quick-error-1.2.3
quote-0.3.15
quote-1.0.7
rand-0.6.5
rand-0.7.3
rand_chacha-0.1.1
rand_chacha-0.2.2
rand_core-0.3.1
rand_core-0.4.2
rand_core-0.5.1
rand_hc-0.1.0
rand_hc-0.2.0
rand_isaac-0.1.1
rand_jitter-0.1.4
rand_os-0.1.3
rand_pcg-0.1.2
rand_xorshift-0.1.1
rdrand-0.4.0
redox_syscall-0.1.57
redox_users-0.3.5
regex-1.4.1
regex-syntax-0.6.20
remove_dir_all-0.5.3
reqwest-0.9.24
rust-argon2-0.8.2
rustc-demangle-0.1.18
rustc_version-0.2.3
rustyline-5.0.6
ryu-1.0.5
schannel-0.1.19
scopeguard-1.1.0
security-framework-0.4.4
security-framework-sys-0.4.3
semver-0.9.0
semver-parser-0.7.0
serde-1.0.117
serde_derive-1.0.117
serde_json-1.0.59
serde_urlencoded-0.5.5
slab-0.4.2
smallvec-0.6.13
socks-0.3.2
string-0.2.1
strsim-0.8.0
structopt-0.3.20
structopt-derive-0.4.13
strum-0.8.0
strum_macros-0.8.0
syn-0.11.11
syn-1.0.48
synom-0.11.3
synstructure-0.12.4
tempfile-3.1.0
termcolor-1.1.0
textwrap-0.11.0
thread_local-1.0.1
time-0.1.44
tinyvec-0.3.4
tokio-0.1.22
tokio-buf-0.1.1
tokio-current-thread-0.1.7
tokio-executor-0.1.10
tokio-io-0.1.13
tokio-reactor-0.1.12
tokio-sync-0.1.8
tokio-tcp-0.1.4
tokio-threadpool-0.1.18
tokio-timer-0.2.13
try-lock-0.2.3
try_from-0.3.2
unicase-2.6.0
unicode-bidi-0.3.4
unicode-normalization-0.1.13
unicode-segmentation-1.6.0
unicode-width-0.1.8
unicode-xid-0.0.4
unicode-xid-0.2.1
url-1.7.2
url-2.1.1
utf8parse-0.1.1
uuid-0.7.4
vcpkg-0.2.10
vec_map-0.8.2
version_check-0.9.2
void-1.0.2
want-0.2.0
wasi-0.9.0+wasi-snapshot-preview1
wasi-0.10.0+wasi-snapshot-preview1
winapi-0.2.8
winapi-0.3.9
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
winreg-0.6.2
winrt-0.4.0
winrt-notification-0.2.2
ws2_32-sys-0.2.1
x11-clipboard-0.3.3
x11-clipboard-0.5.1
xcb-0.8.2
xcb-0.9.0
xml-rs-0.6.1
ydcv-rs-0.4.7
"
inherit cargo

DESCRIPTION="A rust version of YouDao Console Version"
HOMEPAGE="https://github.com/farseerfc/ydcv-rs"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+notify +clipboard test"
RESTRICT="!test? ( test )"
PROPERTIES="test? ( test_network )"

BDEPEND=""
DEPEND=""
RDEPEND="dev-libs/openssl
	notify? ( sys-apps/dbus )
	clipboard? ( x11-libs/libxcb )"

PATCHES="${FILESDIR}/${P}-update-test_explain_html_2-result.diff"
QA_FLAGS_IGNORED="/usr/bin/ydcv-rs"

src_configure() {
	local myfeatures=(
		$(usev notify)
		$(usev clipboard)
	)
	cargo_src_configure --no-default-features
}
