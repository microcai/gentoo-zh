# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.3

EAPI=8

CRATES="
	addr2line@0.22.0
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.3
	allocator-api2@0.2.18
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	anyhow@1.0.86
	async-compression@0.4.12
	async-trait@0.1.81
	atoi@2.0.0
	autocfg@1.3.0
	axum-core@0.4.3
	axum@0.7.5
	backtrace@0.3.73
	base64@0.21.7
	base64@0.22.1
	base64ct@1.6.0
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.6.0
	block-buffer@0.10.4
	bumpalo@3.16.0
	bytemuck@1.16.3
	byteorder@1.5.0
	bytes@1.7.1
	cc@1.1.7
	cfg-if@1.0.0
	chrono@0.4.38
	clap@4.5.13
	clap_builder@4.5.13
	clap_derive@4.5.13
	clap_lex@0.7.2
	color_quant@1.1.0
	colorchoice@1.0.2
	console@0.15.8
	const-oid@0.9.6
	cookie@0.17.0
	cookie@0.18.1
	cookie_store@0.20.0
	cookie_store@0.21.0
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	cpufeatures@0.2.12
	crc-catalog@2.4.0
	crc32fast@1.4.2
	crc@3.2.1
	crossbeam-channel@0.5.13
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-queue@0.3.11
	crossbeam-utils@0.8.20
	crunchy@0.2.2
	crypto-common@0.1.6
	der@0.7.9
	deranged@0.3.11
	dialoguer@0.11.0
	digest@0.10.7
	dotenvy@0.15.7
	either@1.13.0
	encode_unicode@0.3.6
	equivalent@1.0.1
	errno@0.3.9
	etcetera@0.8.0
	event-listener@2.5.3
	exr@1.72.0
	fastrand@2.1.0
	fdeflate@0.3.4
	flate2@1.0.31
	flume@0.11.0
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.1
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-intrusive@0.5.0
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	futures@0.3.30
	generic-array@0.14.7
	getrandom@0.2.15
	gif@0.13.1
	gimli@0.29.0
	glob@0.3.1
	half@2.4.1
	hashbrown@0.14.5
	hashlink@0.8.4
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	hex@0.4.3
	hkdf@0.12.4
	hmac@0.12.1
	home@0.5.9
	http-body-util@0.1.2
	http-body@1.0.1
	http@1.1.0
	httparse@1.9.4
	httpdate@1.0.3
	humantime@2.1.0
	hyper-rustls@0.27.2
	hyper-util@0.1.6
	hyper@1.4.1
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	idna@0.3.0
	idna@0.5.0
	image@0.24.9
	indexmap@2.3.0
	indicatif@0.17.8
	indoc@2.0.5
	instant@0.1.13
	ipnet@2.9.0
	is_terminal_polyfill@1.70.1
	itoa@1.0.11
	jpeg-decoder@0.3.1
	js-sys@0.3.69
	lazy_static@1.5.0
	lebe@0.5.2
	libc@0.2.155
	libm@0.2.8
	libsqlite3-sys@0.27.0
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.22
	m3u8-rs@5.0.5
	matchers@0.1.0
	matchit@0.7.3
	md-5@0.10.6
	memchr@2.7.4
	memoffset@0.9.1
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.4
	mio@1.0.1
	native-tls@0.2.12
	nom@7.1.3
	nu-ansi-term@0.46.0
	num-bigint-dig@0.8.4
	num-conv@0.1.0
	num-integer@0.1.46
	num-iter@0.1.45
	num-traits@0.2.19
	num_threads@0.1.7
	number_prefix@0.4.0
	object@0.36.2
	once_cell@1.19.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-src@300.3.1+3.3.1
	openssl-sys@0.9.103
	openssl@0.10.66
	overload@0.1.1
	parking_lot@0.11.2
	parking_lot@0.12.3
	parking_lot_core@0.8.6
	parking_lot_core@0.9.10
	paste@1.0.15
	pem-rfc7468@0.7.0
	percent-encoding@2.3.1
	pin-project-internal@1.1.5
	pin-project-lite@0.2.14
	pin-project@1.1.5
	pin-utils@0.1.0
	pkcs1@0.7.5
	pkcs8@0.10.2
	pkg-config@0.3.30
	png@0.17.13
	portable-atomic@1.7.0
	powerfmt@0.2.0
	ppv-lite86@0.2.20
	proc-macro2@1.0.86
	psl-types@2.0.11
	publicsuffix@2.2.3
	pyo3-build-config@0.21.2
	pyo3-ffi@0.21.2
	pyo3-macros-backend@0.21.2
	pyo3-macros@0.21.2
	pyo3@0.21.2
	qoi@0.4.1
	qrcode@0.13.0
	quinn-proto@0.11.6
	quinn-udp@0.5.4
	quinn@0.11.3
	quote@1.0.36
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.2.16
	redox_syscall@0.4.1
	redox_syscall@0.5.3
	regex-automata@0.1.10
	regex-automata@0.4.7
	regex-syntax@0.6.29
	regex-syntax@0.8.4
	regex@1.10.6
	reqwest-middleware@0.3.2
	reqwest-retry@0.5.0
	reqwest@0.12.5
	reqwest_cookie_store@0.7.0
	retry-policies@0.3.0
	ring@0.17.8
	rsa@0.9.6
	rustc-demangle@0.1.24
	rustc-hash@2.0.0
	rustix@0.38.34
	rustls-pemfile@1.0.4
	rustls-pemfile@2.1.3
	rustls-pki-types@1.7.0
	rustls-webpki@0.101.7
	rustls-webpki@0.102.6
	rustls@0.21.12
	rustls@0.23.12
	rustversion@1.0.17
	ryu@1.0.18
	schannel@0.1.23
	scopeguard@1.2.0
	sct@0.7.1
	security-framework-sys@2.11.1
	security-framework@2.11.1
	serde@1.0.204
	serde_derive@1.0.204
	serde_json@1.0.122
	serde_path_to_error@0.1.16
	serde_urlencoded@0.7.1
	serde_yaml@0.9.34+deprecated
	sha1@0.10.6
	sha2@0.10.8
	sharded-slab@0.1.7
	shell-words@1.1.0
	signature@2.2.0
	simd-adler32@0.3.7
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.7
	spin@0.9.8
	spki@0.7.3
	sqlformat@0.2.4
	sqlx-core@0.7.4
	sqlx-macros-core@0.7.4
	sqlx-macros@0.7.4
	sqlx-mysql@0.7.4
	sqlx-postgres@0.7.4
	sqlx-sqlite@0.7.4
	sqlx@0.7.4
	stringprep@0.1.5
	strsim@0.11.1
	subtle@2.6.1
	syn@1.0.109
	syn@2.0.72
	sync_wrapper@0.1.2
	sync_wrapper@1.0.1
	target-lexicon@0.12.16
	tempfile@3.11.0
	thiserror-impl@1.0.63
	thiserror@1.0.63
	thread_local@1.1.8
	tiff@0.9.1
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	tokio-macros@2.4.0
	tokio-rustls@0.26.0
	tokio-stream@0.1.15
	tokio-util@0.7.11
	tokio@1.39.2
	tower-http@0.5.2
	tower-layer@0.3.2
	tower-service@0.3.2
	tower@0.4.13
	tracing-appender@0.2.3
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing-log@0.2.0
	tracing-subscriber@0.3.18
	tracing@0.1.40
	try-lock@0.2.5
	typed-builder-macro@0.18.2
	typed-builder@0.18.2
	typenum@1.17.0
	typeshare-annotation@1.0.4
	typeshare@1.0.3
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	unicode-properties@0.1.1
	unicode-segmentation@1.11.0
	unicode-width@0.1.13
	unicode_categories@0.1.1
	unindent@0.2.3
	unsafe-libyaml@0.2.11
	untrusted@0.9.0
	url@2.5.2
	urlencoding@2.1.3
	utf8parse@0.2.2
	valuable@0.1.0
	vcpkg@0.2.15
	version_check@0.9.5
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasite@0.1.0
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-futures@0.4.42
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.92
	wasm-streams@0.4.0
	wasm-timer@0.2.5
	web-sys@0.3.69
	webpki-roots@0.25.4
	webpki-roots@0.26.3
	weezl@0.1.8
	whoami@1.5.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winreg@0.52.0
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zeroize@1.8.1
	zune-inflate@0.2.54
"

inherit cargo

DESCRIPTION="Upload video to bilibili."
HOMEPAGE="https://github.com/biliup/biliup-rs"
SRC_URI="
	https://github.com/biliup/biliup-rs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD ISC MIT MPL-2.0
	Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug"
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_install() {
	dobin "${WORKDIR}/${PN}-${PV}/target/$(usex debug debug release)/biliup"
}
