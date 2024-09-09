# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.22.0
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.3
	aligned-vec@0.5.0
	allocator-api2@0.2.18
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	ansi-to-tui@6.0.0
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.3
	anstyle@1.0.8
	anyhow@1.0.86
	arbitrary@1.3.2
	arc-swap@1.7.1
	arg_enum_proc_macro@0.3.4
	arrayvec@0.7.4
	async-priority-channel@0.2.0
	autocfg@1.3.0
	av1-grain@0.2.3
	avif-serialize@0.8.1
	backtrace@0.3.73
	base64@0.21.7
	base64@0.22.1
	better-panic@0.3.0
	bincode@1.3.3
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.6.0
	bitstream-io@2.5.0
	block-buffer@0.10.4
	block2@0.5.1
	bstr@1.9.1
	built@0.7.4
	bumpalo@3.16.0
	bytemuck@1.16.1
	byteorder-lite@0.1.0
	bytes@1.7.1
	cassowary@0.3.0
	castaway@0.2.3
	cc@1.1.15
	cfg-expr@0.15.8
	cfg-if@1.0.0
	chrono@0.4.38
	clap@4.5.16
	clap_builder@4.5.15
	clap_complete@4.5.24
	clap_complete_fig@4.5.2
	clap_complete_nushell@4.5.3
	clap_derive@4.5.13
	clap_lex@0.7.2
	clipboard-win@5.4.0
	color_quant@1.1.0
	colorchoice@1.0.2
	compact_str@0.8.0
	concurrent-queue@2.5.0
	console@0.15.8
	core-foundation-sys@0.8.6
	crc32fast@1.4.2
	crossbeam-channel@0.5.13
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.20
	crossterm@0.28.1
	crossterm_winapi@0.9.1
	crunchy@0.2.2
	crypto-common@0.1.6
	darling@0.20.9
	darling_core@0.20.9
	darling_macro@0.20.9
	deranged@0.3.11
	derive_builder@0.20.0
	derive_builder_core@0.20.0
	derive_builder_macro@0.20.0
	digest@0.10.7
	dirs-sys@0.4.1
	dirs@5.0.1
	either@1.13.0
	encode_unicode@0.3.6
	equivalent@1.0.1
	erased-serde@0.4.5
	errno@0.3.9
	error-code@3.2.0
	event-listener@4.0.3
	exr@1.72.0
	fdeflate@0.3.4
	fdlimit@0.3.0
	filedescriptor@0.8.2
	filetime@0.2.23
	flate2@1.0.30
	flume@0.11.0
	fnv@1.0.7
	form_urlencoded@1.2.1
	fsevent-sys@4.1.0
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	futures@0.3.30
	generic-array@0.14.7
	getrandom@0.2.15
	getset@0.1.2
	gif@0.13.1
	gimli@0.29.0
	globset@0.4.14
	half@2.4.1
	hashbrown@0.14.5
	heck@0.5.0
	hermit-abi@0.3.9
	home@0.5.9
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	ident_case@1.0.1
	idna@0.5.0
	image-webp@0.1.3
	image@0.25.2
	imagesize@0.13.0
	imgref@1.10.1
	indexmap@2.5.0
	inotify-sys@0.1.5
	inotify@0.10.2
	instability@0.3.2
	instant@0.1.13
	interpolate_name@0.2.4
	is_terminal_polyfill@1.70.1
	itertools@0.12.1
	itertools@0.13.0
	itoa@1.0.11
	jobserver@0.1.32
	jpeg-decoder@0.3.1
	js-sys@0.3.69
	kamadak-exif@0.5.5
	kqueue-sys@1.0.4
	kqueue@1.0.8
	lazy_static@1.5.0
	lebe@0.5.2
	libc@0.2.158
	libfuzzer-sys@0.4.7
	libredox@0.1.3
	line-wrap@0.2.0
	linux-raw-sys@0.4.14
	lock_api@0.4.12
	log@0.4.22
	loop9@0.1.5
	lru@0.12.4
	lua-src@546.0.2
	luajit-src@210.5.8+5790d25
	maybe-rayon@0.1.1
	md-5@0.10.6
	memchr@2.7.4
	minimal-lexical@0.2.1
	miniz_oxide@0.7.4
	mio@0.8.11
	mio@1.0.2
	mlua-sys@0.6.1
	mlua@0.9.9
	mlua_derive@0.9.3
	mutate_once@0.1.1
	new_debug_unreachable@1.0.6
	nom@7.1.3
	noop_proc_macro@0.3.0
	notify-fork@6.1.1
	notify-types-fork@1.0.0
	nu-ansi-term@0.46.0
	num-bigint@0.4.6
	num-conv@0.1.0
	num-derive@0.4.2
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	num_threads@0.1.7
	objc-sys@0.3.5
	objc2-encode@4.0.3
	objc2-foundation@0.2.2
	objc2@0.5.2
	object@0.36.1
	once_cell@1.19.0
	onig@6.4.0
	onig_sys@69.8.1
	option-ext@0.2.0
	ordered-float@2.10.1
	overload@0.1.1
	parking@2.2.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	paste@1.0.15
	percent-encoding@2.3.1
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	pkg-config@0.3.30
	plist@1.6.1
	png@0.17.13
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.86
	profiling-procmacros@1.0.15
	profiling@1.0.15
	qoi@0.4.1
	quick-error@2.0.1
	quick-xml@0.31.0
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	ratatui@0.28.1
	rav1e@0.7.1
	ravif@0.11.9
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.4.1
	redox_syscall@0.5.2
	redox_users@0.4.5
	regex-automata@0.4.7
	regex-syntax@0.8.4
	regex@1.10.6
	rgb@0.8.45
	rustc-demangle@0.1.24
	rustc-hash@2.0.0
	rustix@0.38.35
	rustversion@1.0.17
	ryu@1.0.18
	same-file@1.0.6
	scopeguard@1.2.0
	serde-value@0.7.0
	serde@1.0.209
	serde_derive@1.0.209
	serde_json@1.0.127
	serde_spanned@0.6.7
	sharded-slab@0.1.7
	shell-words@1.1.0
	shlex@1.3.0
	signal-hook-mio@0.2.4
	signal-hook-registry@1.4.2
	signal-hook-tokio@0.3.1
	signal-hook@0.3.17
	simd-adler32@0.3.7
	simd_helpers@0.1.0
	simdutf8@0.1.4
	slab@0.4.9
	smallvec@1.13.2
	socket2@0.5.7
	spin@0.9.8
	static_assertions@1.1.0
	strsim@0.11.1
	strum@0.26.3
	strum_macros@0.26.4
	syn@1.0.109
	syn@2.0.76
	syntect@5.2.0
	system-deps@6.2.2
	target-lexicon@0.12.15
	thiserror-impl@1.0.63
	thiserror@1.0.63
	thread_local@1.1.8
	tiff@0.9.1
	tikv-jemalloc-sys@0.6.0+5.3.0-1-ge13ca993e8ccb9ba9847cc330696e02839f328f7
	tikv-jemallocator@0.6.0
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-macros@2.4.0
	tokio-stream@0.1.15
	tokio-util@0.7.11
	tokio@1.40.0
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.20
	tracing-appender@0.2.3
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing-log@0.2.0
	tracing-subscriber@0.3.18
	tracing@0.1.40
	trash@5.1.1
	typeid@1.0.0
	typenum@1.17.0
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-normalization@0.1.23
	unicode-segmentation@1.11.0
	unicode-truncate@1.1.0
	unicode-width@0.1.13
	url@2.5.2
	urlencoding@2.1.3
	utf8parse@0.2.2
	uzers@0.12.1
	v_frame@0.3.8
	validator@0.18.1
	validator_derive@0.18.1
	valuable@0.1.0
	vergen-gitcl@1.0.0
	vergen-lib@0.1.3
	vergen@9.0.0
	version-compare@0.2.0
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.93
	wasm-bindgen-macro-support@0.2.93
	wasm-bindgen-macro@0.2.93
	wasm-bindgen-shared@0.2.93
	wasm-bindgen@0.2.93
	weezl@0.1.8
	which@6.0.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-core@0.56.0
	windows-implement@0.56.0
	windows-interface@0.56.0
	windows-result@0.1.2
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows@0.56.0
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
	winsafe@0.0.19
	yazi-prebuild@0.1.2
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zune-core@0.4.12
	zune-inflate@0.2.54
	zune-jpeg@0.4.13
"

inherit cargo desktop shell-completion xdg

DESCRIPTION="Yazi image adapter"
HOMEPAGE="https://yazi-rs.github.io"
SRC_URI="
	https://github.com/sxyazi/yazi/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0
	CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+cli"

QA_FLAGS_IGNORED="usr/bin/ya.*"

DOCS=(
	README.md
)

src_prepare() {
	export YAZI_GEN_COMPLETIONS=true
	sed -i -r 's/strip\s+= true/strip = false/' Cargo.toml || die "Sed failed!"
	eapply_user
}

src_compile() {
	cargo_src_compile
	use cli && cargo_src_compile -p "${PN}-cli"
}

src_install() {
	dobin "$(cargo_target_dir)/${PN}"
	use cli && dobin "$(cargo_target_dir)/ya"

	newbashcomp "${S}/yazi-boot/completions/${PN}.bash" "${PN}"
	dozshcomp "${S}/yazi-boot/completions/_${PN}"
	dofishcomp "${S}/yazi-boot/completions/${PN}.fish"

	if use cli; then
		newbashcomp "${S}/yazi-cli/completions/ya.bash" "ya"
		dozshcomp "${S}/yazi-cli/completions/_ya"
		dofishcomp "${S}/yazi-cli/completions/ya.fish"
	fi

	domenu "assets/${PN}.desktop"
	einstalldocs
}
