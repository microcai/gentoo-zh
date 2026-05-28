# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.1
	aho-corasick@1.1.4
	aligned-vec@0.6.4
	alloc-no-stdlib@2.0.4
	alloc-stdlib@0.2.2
	allocator-api2@0.2.21
	android_system_properties@0.1.5
	ansi_colours@1.2.3
	anyhow@1.0.100
	arbitrary@1.4.2
	arg_enum_proc_macro@0.3.4
	arrayvec@0.7.6
	async-compression@0.4.32
	atomic-waker@1.1.2
	autocfg@1.5.0
	av1-grain@0.2.5
	avif-serialize@0.8.6
	base64@0.22.1
	bit-set@0.8.0
	bit-vec@0.8.0
	bit_field@0.10.3
	bitflags@2.10.0
	bitstream-io@2.6.0
	block-buffer@0.10.4
	block@0.1.6
	brotli-decompressor@5.0.0
	brotli@8.0.2
	built@0.7.7
	bumpalo@3.19.0
	bytemuck@1.24.0
	byteorder-lite@0.1.0
	bytes@1.10.1
	cassowary@0.3.0
	castaway@0.2.4
	cc@1.2.45
	cfg-expr@0.15.8
	cfg-if@1.0.4
	chrono@0.4.42
	clipboard-win@2.2.0
	clipboard@0.5.0
	color_quant@1.1.0
	compact_str@0.8.1
	compression-codecs@0.4.31
	compression-core@0.4.29
	console@0.15.11
	convert_case@0.7.1
	core-foundation-sys@0.8.7
	core-foundation@0.9.4
	cpufeatures@0.2.17
	crc32fast@1.5.0
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crossterm@0.28.1
	crossterm@0.29.0
	crossterm_winapi@0.9.1
	crunchy@0.2.4
	crypto-common@0.1.6
	darling_core@0.20.11
	darling_core@0.21.3
	darling_macro@0.20.11
	darling_macro@0.21.3
	darling@0.20.11
	darling@0.21.3
	data-encoding@2.9.0
	deranged@0.5.5
	derive_more-impl@2.0.1
	derive_more@2.0.1
	digest@0.10.7
	displaydoc@0.2.5
	document-features@0.2.12
	dyn-clone@1.0.20
	either@1.15.0
	encode_unicode@1.0.0
	equator-macro@0.4.2
	equator@0.4.2
	equivalent@1.0.2
	errno@0.3.14
	exr@1.73.0
	fancy-regex@0.14.0
	fastrand@2.3.0
	fax_derive@0.2.0
	fax@0.2.6
	fdeflate@0.3.7
	find-msvc-tools@0.1.4
	flate2@1.1.5
	fnv@1.0.7
	foldhash@0.1.5
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.2
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	futures@0.3.31
	generic-array@0.14.9
	getrandom@0.2.16
	getrandom@0.3.4
	gif@0.13.3
	half@2.7.1
	hashbrown@0.15.5
	hashbrown@0.16.0
	heck@0.5.0
	hex@0.4.3
	home@0.5.12
	http-body-util@0.1.3
	http-body@1.0.1
	http_req@0.12.0
	http_req@0.14.1
	http@1.3.1
	httparse@1.10.1
	hyper-tls@0.6.0
	hyper-util@0.1.17
	hyper@1.7.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.64
	icu_collections@2.1.1
	icu_locale_core@2.1.1
	icu_normalizer_data@2.1.1
	icu_normalizer@2.1.1
	icu_properties_data@2.1.1
	icu_properties@2.1.1
	icu_provider@2.1.1
	ident_case@1.0.1
	idna_adapter@1.2.1
	idna@1.1.0
	image-webp@0.2.4
	image@0.25.8
	imgref@1.12.0
	indexmap@2.12.0
	indoc@2.0.7
	instability@0.3.9
	interpolate_name@0.2.4
	invidious@0.7.8
	ipnet@2.11.0
	iri-string@0.7.9
	itertools@0.12.1
	itertools@0.13.0
	itoa@1.0.15
	jobserver@0.1.34
	js-sys@0.3.82
	lazy_static@1.5.0
	lebe@0.5.3
	libc@0.2.177
	libfuzzer-sys@0.4.10
	libmpv-sirno@2.0.2-fork.1
	libmpv-sys-sirno@2.0.0-fork.1
	linux-raw-sys@0.11.0
	linux-raw-sys@0.4.15
	litemap@0.8.1
	litrs@1.0.0
	localzone@0.3.1
	lock_api@0.4.14
	log@0.4.28
	loop9@0.1.5
	lru@0.12.5
	make-cmd@0.1.0
	malloc_buf@0.0.6
	maybe-rayon@0.1.1
	memchr@2.7.6
	miniz_oxide@0.8.9
	mio@1.1.0
	moxcms@0.7.9
	native-tls@0.2.14
	new_debug_unreachable@1.0.6
	nom@8.0.0
	noop_proc_macro@0.3.0
	num-bigint@0.4.6
	num-conv@0.1.0
	num-derive@0.4.2
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	num_threads@0.1.7
	objc-foundation@0.1.1
	objc_id@0.1.1
	objc@0.2.7
	once_cell@1.21.3
	openssl-macros@0.1.1
	openssl-probe@0.1.6
	openssl-sys@0.9.111
	openssl@0.10.75
	parking_lot_core@0.9.12
	parking_lot@0.12.5
	paste@1.0.15
	percent-encoding@2.3.2
	phf_shared@0.11.3
	phf@0.11.3
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	pkg-config@0.3.32
	png@0.18.0
	potential_utf@0.1.4
	powerfmt@0.2.0
	ppv-lite86@0.2.21
	proc-macro2@1.0.103
	profiling-procmacros@1.0.17
	profiling@1.0.17
	pxfm@0.1.25
	qoi@0.4.1
	quick-error@2.0.1
	quote@1.0.42
	r-efi@5.3.0
	rand_chacha@0.3.1
	rand_chacha@0.9.0
	rand_core@0.6.4
	rand_core@0.9.3
	rand@0.8.5
	rand@0.9.2
	ratatui@0.29.0
	rav1e@0.7.1
	ravif@0.11.20
	rayon-core@1.13.0
	redox_syscall@0.5.18
	regex-automata@0.4.13
	regex-syntax@0.8.8
	regex@1.12.2
	reqwest@0.12.24
	ress@0.11.7
	rgb@0.8.52
	rquickjs-core@0.9.0
	rquickjs-sys@0.9.0
	rquickjs@0.9.0
	rustix@0.38.44
	rustix@1.1.2
	rustls-pki-types@1.13.0
	rustversion@1.0.22
	rustypipe@0.11.4
	ryu@1.0.20
	schannel@0.1.28
	scopeguard@1.2.0
	security-framework-sys@2.15.0
	security-framework@2.11.1
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.145
	serde_plain@1.0.2
	serde_spanned@0.6.9
	serde_urlencoded@0.7.1
	serde_with_macros@3.15.1
	serde_with@3.15.1
	serde_yaml_ng@0.10.0
	serde@1.0.228
	sha1@0.10.6
	shlex@1.3.0
	signal-hook-mio@0.2.5
	signal-hook-registry@1.4.6
	signal-hook@0.3.18
	simd-adler32@0.3.7
	simd_helpers@0.1.0
	siphasher@1.0.1
	sixel-rs@0.3.3
	sixel-sys@0.3.1
	slab@0.4.11
	smallvec@1.15.1
	socket2@0.6.1
	stable_deref_trait@1.2.1
	static_assertions@1.1.0
	strsim@0.11.1
	strum_macros@0.26.4
	strum@0.26.3
	syn@2.0.109
	sync_wrapper@1.0.2
	synstructure@0.13.2
	system-deps@6.2.2
	target-lexicon@0.12.16
	tempfile@3.23.0
	termcolor@1.4.1
	thiserror-impl@1.0.69
	thiserror-impl@2.0.17
	thiserror@1.0.69
	thiserror@2.0.17
	tiff@0.10.3
	time-core@0.1.6
	time-macros@0.2.24
	time@0.3.44
	tinystr@0.8.2
	tokio-macros@2.6.0
	tokio-native-tls@0.3.1
	tokio-util@0.7.17
	tokio@1.48.0
	toml_datetime@0.6.11
	toml_edit@0.22.27
	toml@0.8.23
	tower-http@0.6.6
	tower-layer@0.3.3
	tower-service@0.3.3
	tower@0.5.2
	tracing-attributes@0.1.30
	tracing-core@0.1.34
	tracing@0.1.41
	traitobject@0.1.1
	try-lock@0.2.5
	tui-additions@0.4.3
	typemap@0.3.3
	typenum@1.19.0
	unicase@2.8.1
	unicode-ident@1.0.22
	unicode-segmentation@1.12.0
	unicode-truncate@1.1.0
	unicode-width@0.1.14
	unicode-width@0.2.0
	unicode-xid@0.2.6
	unsafe-any@0.4.2
	unsafe-libyaml@0.2.11
	url@2.5.7
	urlencoding@2.1.3
	utf8_iter@1.0.4
	v_frame@0.3.9
	vcpkg@0.2.15
	version-compare@0.2.1
	version_check@0.9.5
	viuer@0.9.2
	want@0.3.1
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.1+wasi-0.2.4
	wasm-bindgen-futures@0.4.55
	wasm-bindgen-macro-support@0.2.105
	wasm-bindgen-macro@0.2.105
	wasm-bindgen-shared@0.2.105
	wasm-bindgen@0.2.105
	web-sys@0.3.82
	weezl@0.1.11
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.54.0
	windows-core@0.62.2
	windows-implement@0.60.2
	windows-interface@0.59.3
	windows-link@0.2.1
	windows-result@0.1.2
	windows-result@0.4.1
	windows-strings@0.5.1
	windows-sys@0.59.0
	windows-sys@0.60.2
	windows-sys@0.61.2
	windows-targets@0.52.6
	windows-targets@0.53.5
	windows@0.54.0
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.1
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.1
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.1
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.1
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.1
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.1
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.1
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.1
	winnow@0.7.13
	wit-bindgen@0.46.0
	writeable@0.6.2
	x11-clipboard@0.3.3
	xcb@0.8.2
	yoke-derive@0.8.1
	yoke@0.8.1
	zerocopy-derive@0.8.27
	zerocopy@0.8.27
	zerofrom-derive@0.1.6
	zerofrom@0.1.6
	zeroize_derive@1.4.2
	zeroize@1.8.2
	zerotrie@0.2.3
	zerovec-derive@0.11.2
	zerovec@0.11.5
	zune-core@0.4.12
	zune-inflate@0.2.54
	zune-jpeg@0.4.21
"

PYTHON_COMPAT=( python3_{11..15} )
RUST_MIN_VER="1.88.0"

inherit cargo optfeature python-any-r1

DESCRIPTION="Aesthetically pleasing YouTube TUI written in Rust"
HOMEPAGE="
	https://tui.siri.ws/youtube/
	https://github.com/Siriusmart/youtube-tui
"
# We build the SRC_URI manually to use the more reliable static.crates.io
# instead of the crates.io API which often returns 403 Forbidden.
SRC_URI="https://github.com/Siriusmart/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
for _crate in ${CRATES}; do
	_name=${_crate%@*}
	_version=${_crate##*@}
	SRC_URI+=" https://static.crates.io/crates/${_name}/${_name}-${_version}.crate"
done
unset _crate _name _version


LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
	0BSD AGPL-3 Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2
	Boost-1.0 CC0-1.0 GPL-3 LGPL-2.1 LGPL-2.1+ LGPL-3+ MIT
	Unicode-3.0 Unlicense UoI-NCSA ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+clipboard +halfblock invidious +mpv +rustypipe +sixel"
REQUIRED_USE="|| ( invidious rustypipe )"

RDEPEND="
	dev-libs/openssl:=
	clipboard? ( x11-libs/libxcb:= )
	mpv? ( media-video/mpv:=[libmpv] )
	sixel? ( media-libs/libsixel:= )
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	clipboard? (
		${PYTHON_DEPS}
	)
"

pkg_setup() {
	if use clipboard; then
		python-any-r1_pkg_setup
	fi

	rust_pkg_setup
}

src_prepare() {
	default

	# Use Gentoo's libsixel instead of building the bundled copy from sixel-sys.
	sed -i \
		-e 's/let testing_build = false;/let testing_build = true;/' \
		"${ECARGO_VENDOR}/sixel-sys-0.3.1/build.rs" || die
}

src_configure() {
	local myfeatures=(
		$(usev clipboard)
		$(usev halfblock)
		$(usev invidious)
		$(usev mpv)
		$(usev rustypipe)
		$(usev sixel)
	)

	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install
	dodoc README.md
}

pkg_postinst() {
	optfeature "external video playback" media-video/mpv
	optfeature "video downloads" net-misc/yt-dlp
}
