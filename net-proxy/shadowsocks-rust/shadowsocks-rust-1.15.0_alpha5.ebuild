# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aead-0.4.3
	aes-0.7.5
	aes-0.8.1
	aes-gcm-0.9.4
	aes-gcm-siv-0.10.3
	aho-corasick-0.7.18
	anyhow-1.0.57
	arc-swap-1.5.0
	arrayref-0.3.6
	arrayvec-0.7.2
	async-trait-0.1.56
	atty-0.2.14
	autocfg-1.1.0
	base16ct-0.1.1
	base64-0.13.0
	bit-vec-0.6.3
	bitflags-1.3.2
	blake3-1.3.1
	block-buffer-0.7.3
	block-buffer-0.10.2
	block-padding-0.1.5
	bloomfilter-1.0.9
	boxfnonce-0.1.1
	build-time-0.1.1
	bumpalo-3.10.0
	byte-tools-0.3.1
	byte_string-1.0.0
	byteorder-1.4.3
	bytes-1.1.0
	cc-1.0.73
	ccm-0.4.4
	cfg-if-1.0.0
	chacha20-0.8.1
	chacha20poly1305-0.9.0
	checked_int_cast-1.0.0
	chrono-0.4.19
	cipher-0.3.0
	cipher-0.4.3
	clap-3.1.18
	clap_lex-0.2.0
	cmake-0.1.48
	const-oid-0.7.1
	constant_time_eq-0.1.5
	core-foundation-0.9.3
	core-foundation-sys-0.8.3
	cpufeatures-0.2.2
	crossbeam-channel-0.5.4
	crossbeam-utils-0.8.8
	crypto-bigint-0.3.2
	crypto-common-0.1.3
	ctr-0.8.0
	daemonize-0.4.1
	data-encoding-2.3.2
	der-0.5.1
	derivative-2.2.0
	digest-0.8.1
	digest-0.9.0
	digest-0.10.3
	directories-4.0.1
	dirs-4.0.0
	dirs-sys-0.3.7
	ecdsa-0.13.4
	ed25519-1.5.2
	elliptic-curve-0.11.12
	enum-as-inner-0.4.0
	env_logger-0.9.0
	etherparse-0.10.1
	exitcode-1.1.2
	fake-simd-0.1.2
	fastrand-1.7.0
	filetime-0.2.16
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	fs_extra-1.2.0
	fsevent-sys-4.1.0
	futures-0.3.21
	futures-channel-0.3.21
	futures-core-0.3.21
	futures-executor-0.3.21
	futures-io-0.3.21
	futures-macro-0.3.21
	futures-sink-0.3.21
	futures-task-0.3.21
	futures-util-0.3.21
	generic-array-0.12.4
	generic-array-0.14.5
	getrandom-0.2.6
	ghash-0.4.4
	h2-0.3.13
	hashbrown-0.11.2
	heck-0.4.0
	hermit-abi-0.1.19
	hkdf-0.12.3
	hmac-0.12.1
	hostname-0.3.1
	http-0.2.7
	http-body-0.4.5
	httparse-1.7.1
	httpdate-1.0.2
	humantime-2.1.0
	hyper-0.14.19
	idna-0.2.3
	indexmap-1.8.2
	inotify-0.9.6
	inotify-sys-0.1.5
	inout-0.1.3
	instant-0.1.12
	ioctl-sys-0.6.0
	ipconfig-0.3.0
	ipnet-2.5.0
	iprange-0.6.7
	itoa-1.0.2
	jemalloc-sys-0.5.0+5.3.0
	jemallocator-0.5.0
	js-sys-0.3.57
	json5-0.4.1
	kqueue-1.0.6
	kqueue-sys-1.0.3
	lazy_static-1.4.0
	libc-0.2.126
	libmimalloc-sys-0.1.25
	linked-hash-map-0.5.4
	lock_api-0.4.7
	log-0.4.17
	log-mdc-0.1.0
	log4rs-1.1.1
	lru-cache-0.1.2
	lru_time_cache-0.11.11
	managed-0.8.0
	maplit-1.0.2
	match_cfg-0.1.0
	matches-0.1.9
	md-5-0.10.1
	md5-asm-0.5.0
	memchr-2.5.0
	memoffset-0.6.5
	mimalloc-0.1.29
	mio-0.8.3
	native-tls-0.2.10
	nix-0.24.1
	notify-5.0.0-pre.15
	num-integer-0.1.45
	num-traits-0.2.15
	num_cpus-1.13.1
	once_cell-1.12.0
	opaque-debug-0.2.3
	opaque-debug-0.3.0
	openssl-0.10.40
	openssl-macros-0.1.0
	openssl-probe-0.1.5
	openssl-sys-0.9.74
	ordered-float-2.10.0
	os_str_bytes-6.1.0
	p256-0.10.1
	p384-0.9.0
	parking_lot-0.12.1
	parking_lot_core-0.9.3
	percent-encoding-2.1.0
	pest-2.1.3
	pest_derive-2.1.0
	pest_generator-2.1.3
	pest_meta-2.1.3
	pin-project-1.0.10
	pin-project-internal-1.0.10
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pkg-config-0.3.25
	poly1305-0.7.2
	polyval-0.5.3
	ppv-lite86-0.2.16
	proc-macro2-1.0.39
	qrcode-0.12.0
	quick-error-1.2.3
	quote-1.0.18
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.3
	redox_syscall-0.2.13
	redox_users-0.4.3
	regex-1.5.6
	regex-syntax-0.6.26
	remove_dir_all-0.5.3
	resolv-conf-0.7.0
	ring-0.16.20
	ring-compat-0.4.1
	rpassword-6.0.1
	rpmalloc-0.2.2
	rpmalloc-sys-0.2.3+b097fd0
	rustls-0.20.6
	rustls-native-certs-0.6.2
	rustls-pemfile-0.3.0
	rustls-pemfile-1.0.0
	ryu-1.0.10
	same-file-1.0.6
	schannel-0.1.20
	scopeguard-1.1.0
	sct-0.7.0
	sec1-0.2.1
	security-framework-2.6.1
	security-framework-sys-2.6.1
	sendfd-0.4.1
	serde-1.0.137
	serde-value-0.7.0
	serde_derive-1.0.137
	serde_json-1.0.81
	serde_urlencoded-0.7.1
	serde_yaml-0.8.24
	sha-1-0.8.2
	sha1-0.10.1
	sha1-asm-0.5.1
	shadowsocks-crypto-0.4.0
	signal-hook-registry-1.4.0
	signature-1.4.0
	siphasher-0.3.10
	slab-0.4.6
	smallvec-1.8.0
	smoltcp-0.8.1
	snmalloc-rs-0.3.0
	snmalloc-sys-0.3.0
	socket2-0.4.4
	spin-0.5.2
	spin-0.9.3
	strsim-0.10.0
	subtle-2.4.1
	syn-1.0.96
	tcmalloc-0.3.0
	tcmalloc-sys-0.3.0
	tempfile-3.3.0
	termcolor-1.1.3
	terminal_size-0.1.17
	textwrap-0.15.0
	thiserror-1.0.31
	thiserror-impl-1.0.31
	thread-id-4.0.0
	time-0.1.43
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	tokio-1.18.2
	tokio-macros-1.7.0
	tokio-native-tls-0.3.0
	tokio-rustls-0.23.4
	tokio-tfo-0.2.0
	tokio-util-0.6.10
	tokio-util-0.7.2
	tower-0.4.12
	tower-layer-0.3.1
	tower-service-0.3.1
	tracing-0.1.34
	tracing-attributes-0.1.21
	tracing-core-0.1.26
	traitobject-0.1.0
	trust-dns-proto-0.21.2
	trust-dns-resolver-0.21.2
	try-lock-0.2.3
	tun-0.5.3
	typemap-0.3.3
	typenum-1.15.0
	ucd-trie-0.1.3
	unicode-bidi-0.3.8
	unicode-ident-1.0.0
	unicode-normalization-0.1.19
	universal-hash-0.4.1
	unsafe-any-0.4.2
	untrusted-0.7.1
	url-2.2.2
	vcpkg-0.2.15
	version_check-0.9.4
	walkdir-2.3.2
	want-0.3.0
	wasi-0.10.2+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.80
	wasm-bindgen-backend-0.2.80
	wasm-bindgen-macro-0.2.80
	wasm-bindgen-macro-support-0.2.80
	wasm-bindgen-shared-0.2.80
	web-sys-0.3.57
	webpki-0.22.0
	webpki-roots-0.22.3
	widestring-0.5.1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.36.1
	windows_aarch64_msvc-0.36.1
	windows_i686_gnu-0.36.1
	windows_i686_msvc-0.36.1
	windows_x86_64_gnu-0.36.1
	windows_x86_64_msvc-0.36.1
	winreg-0.7.0
	xdg-2.4.1
	yaml-rust-0.4.5
	zeroize-1.3.0
"

inherit cargo systemd

MY_PV=${PV/_alpha/-alpha.}

DESCRIPTION="A Rust port of shadowsocks."
HOMEPAGE="https://github.com/shadowsocks/shadowsocks-rust"
SRC_URI="https://github.com/shadowsocks/shadowsocks-rust/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)"
RESTRICT="mirror strip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~mips ~x86"
IUSE="redir tun"

S="${WORKDIR}/${PN}-${MY_PV}"

QA_FLAGS_IGNORED="
	usr/bin/sslocal
	usr/bin/ssmanager
	usr/bin/ssurl
	usr/bin/ssservice
	usr/bin/ssserver
"

src_configure() {
	# Should we provide stream cipher protocol option?
	local myfeatures=(
		$(usex redir local-redir "")
		$(usex tun local-tun "")
	)
	cargo_src_configure
}

src_install() {
#	if use debug; then
#		dobin target/debug/ss{local,manager,server,service,url}
#	else
#		dobin target/release/ss{local,manager,server,service,url}
#	fi
	cargo_src_install

	systemd_newunit "${FILESDIR}/shadowsocks-rust_at.service" shadowsocks-rust@.service
	systemd_newunit "${FILESDIR}/shadowsocks-rust-server_at.service" shadowsocks-rust-server@.service

	insinto "/etc/${PN}"
	doins examples/*.json
}
