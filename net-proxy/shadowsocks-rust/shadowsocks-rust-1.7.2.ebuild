# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
adler32-1.0.3
aesni-0.6.0
aho-corasick-0.7.6
ansi_term-0.11.0
arc-swap-0.4.1
arrayvec-0.4.11
atty-0.2.13
autocfg-0.1.5
backtrace-0.3.34
backtrace-sys-0.1.31
base64-0.10.1
bitflags-1.1.0
block-buffer-0.7.3
block-cipher-trait-0.6.2
block-padding-0.1.4
byte-tools-0.3.1
byte_string-1.0.0
byteorder-1.3.2
bytes-0.4.12
bzip2-0.3.3
bzip2-sys-0.1.7
c2-chacha-0.2.2
cc-1.0.38
cfg-if-0.1.9
checked_int_cast-1.0.0
chrono-0.4.7
clap-2.33.0
cloudabi-0.0.3
cmac-0.2.0
crc32fast-1.2.0
crossbeam-deque-0.7.1
crossbeam-epoch-0.7.2
crossbeam-queue-0.1.2
crossbeam-utils-0.6.6
crypto-mac-0.7.0
ctr-0.3.2
data-encoding-2.1.2
dbl-0.2.1
digest-0.8.1
dns-parser-0.8.0
dtoa-0.4.4
enum-as-inner-0.2.1
env_logger-0.6.2
failure-0.1.5
failure_derive-0.1.5
fake-simd-0.1.2
filetime-0.2.6
flate2-0.2.20
flate2-1.0.9
fnv-1.0.6
foreign-types-0.3.2
foreign-types-shared-0.1.1
fuchsia-cprng-0.1.1
fuchsia-zircon-0.3.3
fuchsia-zircon-sys-0.3.3
futures-0.1.28
generic-array-0.12.3
getrandom-0.1.8
h2-0.1.26
hostname-0.1.5
http-0.1.18
humantime-1.2.0
idna-0.1.5
idna-0.2.0
indexmap-1.0.2
iovec-0.1.2
ipconfig-0.2.1
itoa-0.4.4
json5-0.2.5
kernel32-sys-0.2.2
lazy_static-1.3.0
libc-0.2.60
libsodium-ffi-0.1.17
linked-hash-map-0.5.2
lock_api-0.1.5
log-0.4.8
lru-cache-0.1.2
maplit-1.0.1
matches-0.1.8
md-5-0.8.0
memchr-2.2.1
memoffset-0.5.1
mime-0.3.13
miniz-sys-0.1.12
miniz_oxide-0.3.0
miniz_oxide_c_api-0.2.3
mio-0.6.19
mio-named-pipes-0.1.6
mio-uds-0.6.7
miow-0.2.1
miow-0.3.3
miscreant-0.4.2
msdos_time-0.1.6
net2-0.2.33
nodrop-0.1.13
num-integer-0.1.41
num-traits-0.2.8
num_cpus-1.10.1
opaque-debug-0.2.3
openssl-0.10.24
openssl-sys-0.9.48
owning_ref-0.4.0
parking_lot-0.7.1
parking_lot_core-0.4.0
percent-encoding-1.0.1
percent-encoding-2.1.0
pest-2.1.1
pest_derive-2.1.0
pest_generator-2.1.0
pest_meta-2.1.1
pkg-config-0.3.15
pmac-0.2.0
podio-0.1.6
ppv-lite86-0.2.5
proc-macro2-0.4.30
qrcode-0.10.1
quick-error-1.2.2
quote-0.6.13
rand-0.6.5
rand-0.7.0
rand_chacha-0.1.1
rand_chacha-0.2.1
rand_core-0.3.1
rand_core-0.4.2
rand_core-0.5.0
rand_hc-0.1.0
rand_hc-0.2.0
rand_isaac-0.1.1
rand_jitter-0.1.4
rand_os-0.1.3
rand_pcg-0.1.2
rand_xorshift-0.1.1
rdrand-0.4.0
redox_syscall-0.1.56
regex-1.2.1
regex-syntax-0.6.11
resolv-conf-0.6.2
ring-0.14.6
rustc-demangle-0.1.15
rustc_version-0.2.3
rustls-0.15.2
scopeguard-0.3.3
scopeguard-1.0.0
sct-0.5.0
semver-0.9.0
semver-parser-0.7.0
serde-1.0.98
serde_derive-1.0.98
serde_urlencoded-0.5.5
sha-1-0.8.1
signal-hook-0.1.10
signal-hook-registry-1.1.1
slab-0.4.2
smallvec-0.6.10
socket2-0.3.10
spin-0.5.0
stable_deref_trait-1.1.1
stream-cipher-0.3.0
string-0.2.1
strsim-0.8.0
subtle-1.0.0
subtle-2.1.1
syn-0.15.42
synstructure-0.10.2
tar-0.4.26
termcolor-1.0.5
textwrap-0.11.0
thread_local-0.3.6
time-0.1.42
tokio-0.1.22
tokio-codec-0.1.1
tokio-current-thread-0.1.6
tokio-executor-0.1.8
tokio-fs-0.1.6
tokio-io-0.1.12
tokio-process-0.2.4
tokio-reactor-0.1.9
tokio-rustls-0.9.3
tokio-signal-0.2.7
tokio-sync-0.1.6
tokio-tcp-0.1.3
tokio-threadpool-0.1.15
tokio-timer-0.2.11
tokio-udp-0.1.3
tokio-uds-0.2.5
trust-dns-https-0.3.4
trust-dns-proto-0.7.4
trust-dns-resolver-0.11.1
trust-dns-rustls-0.6.4
typed-headers-0.1.1
typenum-1.10.0
ucd-trie-0.1.2
unicase-2.4.0
unicode-bidi-0.3.4
unicode-normalization-0.1.8
unicode-width-0.1.5
unicode-xid-0.1.0
untrusted-0.6.2
unwrap-1.2.1
url-1.7.2
url-2.1.0
vcpkg-0.2.7
vec_map-0.8.1
version_check-0.1.5
webpki-0.19.1
webpki-roots-0.16.0
widestring-0.4.0
winapi-0.2.8
winapi-0.3.7
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.2
winapi-x86_64-pc-windows-gnu-0.4.0
wincolor-1.0.1
winreg-0.6.2
winutil-0.1.1
ws2_32-sys-0.2.1
xattr-0.2.2
zeroize-0.5.2
zip-0.2.8
"

inherit cargo systemd

DESCRIPTION="A Rust port of shadowsocks "
HOMEPAGE="https://github.com/shadowsocks/shadowsocks-rust"
SRC_URI="
	https://github.com/shadowsocks/shadowsocks-rust/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"
RESTRICT="primaryuri"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DOCS=( README.md )
DEPEND="
	dev-libs/libsodium
"

QA_FLAGS_IGNORED="
	/usr/bin/ssdns
	/usr/bin/sslocal
	/usr/bin/ssserver
	/usr/bin/ssurl
"

src_compile() {
	cargo_src_compile
}

src_install() {
	cargo_src_install --path=.

	einstalldocs

	insinto /etc/shadowsocks-rust/
	doins "${FILESDIR}"/config.json

	newinitd "${FILESDIR}"/shadowsocks-rust.initd shadowsocks-rust
	dosym shadowsocks-rust /etc/init.d/shadowsocks-rust.local
	dosym shadowsocks-rust /etc/init.d/shadowsocks-rust.server

	systemd_dounit "${FILESDIR}"/shadowsocks-rust.service
	systemd_newunit "${FILESDIR}"/shadowsocks-rust-local-at.service shadowsocks-rust-local@.service
	systemd_newunit "${FILESDIR}"/shadowsocks-rust-server-at.service shadowsocks-rust-server@.service
}

pkg_setup() {
	elog "You need to choose the mode"
	elog "  server: rc-update add shadowsocks-rust.local default"
	elog "  client: rc-update add shadowsocks-rust.server default"
}
