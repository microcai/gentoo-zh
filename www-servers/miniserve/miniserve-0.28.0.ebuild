# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.3

EAPI=8

CRATES="
	actix-codec@0.5.2
	actix-files@0.6.6
	actix-http@3.9.0
	actix-macros@0.2.4
	actix-multipart-derive@0.7.0
	actix-multipart@0.7.2
	actix-router@0.5.3
	actix-rt@2.10.0
	actix-server@2.5.0
	actix-service@2.0.2
	actix-tls@3.4.0
	actix-utils@3.0.1
	actix-web-codegen@4.3.0
	actix-web-httpauth@0.8.2
	actix-web@4.9.0
	addr2line@0.24.1
	adler2@2.0.0
	adler32@1.2.0
	ahash@0.8.11
	aho-corasick@1.1.3
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	allocator-api2@0.2.18
	alphanumeric-sort@1.5.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	anyhow@1.0.88
	arbitrary@1.3.2
	assert_cmd@2.0.16
	assert_fs@1.1.2
	autocfg@1.3.0
	backtrace@0.3.74
	base64@0.22.1
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@2.6.0
	block-buffer@0.10.4
	brotli-decompressor@4.0.1
	brotli@6.0.0
	bstr@1.10.0
	bumpalo@3.16.0
	byteorder@1.5.0
	bytes@1.7.1
	bytesize@1.3.0
	bytestring@1.3.1
	caseless@0.2.1
	cc@1.1.18
	cfg-if@1.0.0
	chrono-humanize@0.2.3
	chrono@0.4.38
	clap@4.5.17
	clap_builder@4.5.17
	clap_complete@4.5.26
	clap_derive@4.5.13
	clap_lex@0.7.2
	clap_mangen@0.2.23
	codemap@0.1.3
	colorchoice@1.0.2
	colored@2.1.0
	comrak@0.28.0
	convert_case@0.4.0
	core-foundation-sys@0.8.7
	core2@0.4.0
	cpufeatures@0.2.14
	crc32fast@1.4.2
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	darling@0.20.10
	darling_core@0.20.10
	darling_macro@0.20.10
	dary_heap@0.3.6
	deranged@0.3.11
	derive_arbitrary@1.3.2
	derive_builder@0.20.1
	derive_builder_core@0.20.1
	derive_builder_macro@0.20.1
	derive_more@0.99.18
	deunicode@1.6.0
	diff@0.1.13
	difflib@0.4.0
	digest@0.10.7
	displaydoc@0.2.5
	doc-comment@0.3.3
	encoding_rs@0.8.34
	entities@1.0.1
	equivalent@1.0.1
	errno@0.3.9
	fake-tty@0.3.1
	fast_qr@0.12.5
	fastrand@2.1.1
	filetime@0.2.25
	flate2@1.0.33
	float-cmp@0.9.0
	fnv@1.0.7
	form_urlencoded@1.2.1
	futf@0.1.5
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-timer@3.0.3
	futures-util@0.3.30
	futures@0.3.30
	generic-array@0.14.7
	getrandom@0.2.15
	gimli@0.31.0
	glob@0.3.1
	globset@0.4.15
	globwalk@0.9.1
	grass@0.13.4
	grass_compiler@0.13.4
	h2@0.3.26
	hashbrown@0.14.5
	heck@0.5.0
	hermit-abi@0.3.9
	hex@0.4.3
	html5ever@0.26.0
	http-body-util@0.1.2
	http-body@1.0.1
	http-range@0.1.5
	http@0.2.12
	http@1.1.0
	httparse@1.9.4
	httpdate@1.0.3
	hyper-rustls@0.27.3
	hyper-util@0.1.8
	hyper@1.4.1
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	ident_case@1.0.1
	idna@0.5.0
	if-addrs@0.13.3
	ignore@0.4.23
	impl-more@0.1.6
	include_sass@0.13.4
	indexmap@2.5.0
	ipnet@2.10.0
	is_terminal_polyfill@1.70.1
	itoa@1.0.11
	jobserver@0.1.32
	js-sys@0.3.70
	language-tags@0.3.2
	lasso@0.7.3
	lazy_static@1.5.0
	libc@0.2.158
	libflate@2.1.0
	libflate_lz77@2.1.0
	libredox@0.1.3
	linux-raw-sys@0.4.14
	local-channel@0.1.5
	local-waker@0.1.4
	lock_api@0.4.12
	log@0.4.22
	mac@0.1.1
	markup5ever@0.11.0
	markup5ever_rcdom@0.2.0
	maud@0.26.0
	maud_macros@0.26.0
	memchr@2.7.4
	mime@0.3.17
	mime_guess@2.0.5
	miniz_oxide@0.8.0
	mio@1.0.2
	nanoid@0.4.0
	new_debug_unreachable@1.0.6
	normalize-line-endings@0.3.0
	num-conv@0.1.0
	num-traits@0.2.19
	num_threads@0.1.7
	object@0.36.4
	once_cell@1.19.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	parse-size@1.0.0
	paste@1.0.15
	percent-encoding@2.3.1
	phf@0.10.1
	phf@0.11.2
	phf_codegen@0.10.0
	phf_generator@0.10.0
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.10.0
	phf_shared@0.11.2
	pin-project-internal@1.1.5
	pin-project-lite@0.2.14
	pin-project@1.1.5
	pin-utils@0.1.0
	pkg-config@0.3.30
	port_check@0.2.1
	powerfmt@0.2.0
	ppv-lite86@0.2.20
	precomputed-hash@0.1.1
	predicates-core@1.0.8
	predicates-tree@1.0.11
	predicates@3.1.2
	pretty_assertions@1.4.0
	proc-macro-crate@3.2.0
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.86
	quinn-proto@0.11.8
	quinn-udp@0.5.5
	quinn@0.11.5
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.5.4
	regex-automata@0.4.7
	regex-lite@0.1.6
	regex-syntax@0.8.4
	regex@1.10.6
	relative-path@1.9.3
	reqwest@0.12.7
	ring@0.17.8
	rle-decode-fast@1.0.3
	roff@0.2.2
	rstest@0.22.0
	rstest_macros@0.22.0
	rustc-demangle@0.1.24
	rustc-hash@2.0.0
	rustc_version@0.4.1
	rustix@0.38.37
	rustls-pemfile@2.1.3
	rustls-pki-types@1.8.0
	rustls-webpki@0.102.8
	rustls@0.23.13
	rustversion@1.0.17
	ryu@1.0.18
	same-file@1.0.6
	scopeguard@1.2.0
	select@0.6.0
	semver@1.0.23
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.128
	serde_plain@1.0.2
	serde_urlencoded@0.7.1
	sha1@0.10.6
	sha2@0.10.8
	shlex@1.3.0
	signal-hook-registry@1.4.2
	simplelog@0.12.2
	siphasher@0.3.11
	slab@0.4.9
	slug@0.1.6
	smallvec@1.13.2
	socket2@0.5.7
	spin@0.9.8
	string_cache@0.8.7
	string_cache_codegen@0.5.2
	strsim@0.11.1
	strum@0.26.3
	strum_macros@0.26.4
	subtle@2.6.1
	syn@1.0.109
	syn@2.0.77
	sync_wrapper@1.0.1
	tar@0.4.41
	tempfile@3.12.0
	tendril@0.4.3
	termcolor@1.4.1
	terminal_size@0.3.0
	termtree@0.4.1
	thiserror-impl@1.0.63
	thiserror@1.0.63
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	tokio-rustls@0.26.0
	tokio-util@0.7.12
	tokio@1.40.0
	toml_datetime@0.6.8
	toml_edit@0.22.20
	tower-layer@0.3.3
	tower-service@0.3.3
	tower@0.4.13
	tracing-core@0.1.32
	tracing@0.1.40
	try-lock@0.2.5
	typed-arena@2.0.2
	typenum@1.17.0
	unicase@2.7.0
	unicode-bidi@0.3.15
	unicode-ident@1.0.13
	unicode-normalization@0.1.23
	unicode_categories@0.1.1
	untrusted@0.9.0
	url@2.5.2
	utf-8@0.7.6
	utf8parse@0.2.2
	v_htmlescape@0.15.8
	version_check@0.9.5
	wait-timeout@0.2.0
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.93
	wasm-bindgen-futures@0.4.43
	wasm-bindgen-macro-support@0.2.93
	wasm-bindgen-macro@0.2.93
	wasm-bindgen-shared@0.2.93
	wasm-bindgen@0.2.93
	web-sys@0.3.70
	webpki-roots@0.26.5
	winapi-util@0.1.9
	windows-core@0.52.0
	windows-registry@0.2.0
	windows-result@0.2.0
	windows-strings@0.1.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
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
	winnow@0.6.18
	xattr@1.3.1
	xml5ever@0.17.0
	yansi@0.5.1
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zeroize@1.8.1
	zip@2.2.0
	zstd-safe@7.2.1
	zstd-sys@2.0.13+zstd.1.5.6
	zstd@0.13.2
"

inherit cargo

DESCRIPTION="For when you really just want to serve some files over HTTP right now!"
HOMEPAGE="https://github.com/svenstaro/miniserve"
SRC_URI="
	https://github.com/svenstaro/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD-2 BSD ISC MIT MPL-2.0 Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
