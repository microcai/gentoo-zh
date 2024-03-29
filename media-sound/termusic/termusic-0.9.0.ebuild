# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.2

EAPI=8

CRATES="
	ab_glyph@0.2.23
	ab_glyph_rasterizer@0.1.8
	addr2line@0.21.0
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.2
	allocator-api2@0.2.16
	alsa-sys@0.3.1
	alsa@0.9.0
	android-activity@0.5.2
	android-properties@0.2.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	ansi_colours@1.2.2
	anstream@0.6.13
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anstyle@1.0.6
	anyhow@1.0.81
	arrayref@0.3.7
	arrayvec@0.7.4
	as-raw-xcb-connection@1.0.1
	async-channel@2.2.0
	async-compression@0.4.6
	async-stream-impl@0.3.5
	async-stream@0.3.5
	async-trait@0.1.78
	atom_syndication@0.12.2
	atomic-waker@1.1.2
	atomic@0.6.0
	autocfg@1.1.0
	axum-core@0.3.4
	axum@0.6.20
	backtrace@0.3.69
	base64@0.21.7
	base64@0.22.0
	bindgen@0.69.4
	bit_field@0.10.2
	bitflags@1.3.2
	bitflags@2.4.2
	block-sys@0.2.1
	block2@0.3.0
	block@0.1.6
	bumpalo@3.15.4
	bytemuck@1.15.0
	byteorder@1.5.0
	bytes@1.5.0
	calloop-wayland-source@0.2.0
	calloop@0.12.4
	camino@1.1.6
	cassowary@0.3.0
	cc@1.0.90
	cesu8@1.1.0
	cexpr@0.6.0
	cfg-expr@0.15.7
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	chrono@0.4.35
	clang-sys@1.7.0
	clap@4.5.3
	clap_builder@4.5.2
	clap_derive@4.5.3
	clap_lex@0.7.0
	cocoa-foundation@0.1.2
	cocoa@0.24.1
	color_quant@1.1.0
	colorchoice@1.0.0
	colored@2.1.0
	combine@4.6.6
	concurrent-queue@2.4.0
	console@0.15.8
	cookie@0.17.0
	cookie_store@0.20.0
	core-foundation-sys@0.8.6
	core-foundation@0.9.4
	core-graphics-types@0.1.3
	core-graphics@0.22.3
	core-graphics@0.23.1
	coreaudio-rs@0.11.3
	coreaudio-sys@0.2.15
	cpal@0.15.3
	crc32fast@1.4.0
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crossterm@0.25.0
	crossterm@0.27.0
	crossterm_winapi@0.9.1
	crunchy@0.2.2
	ctrlc@3.4.4
	cursor-icon@1.1.0
	darling@0.14.4
	darling_core@0.14.4
	darling_macro@0.14.4
	dasp_sample@0.11.0
	data-encoding@2.5.0
	dbus-crossroads@0.5.2
	dbus@0.9.7
	deranged@0.3.11
	derive_builder@0.12.0
	derive_builder_core@0.12.0
	derive_builder_macro@0.12.0
	diff@0.1.13
	diligent-date-parser@0.1.4
	dirs-sys@0.4.1
	dirs@5.0.1
	discord-rich-presence@0.2.3
	dispatch@0.2.0
	dlib@0.5.2
	downcast-rs@1.2.0
	either@1.10.0
	encode_unicode@0.3.6
	encoding_rs@0.8.33
	entities@1.0.1
	equivalent@1.0.1
	errno@0.3.8
	escaper@0.1.1
	event-listener-strategy@0.5.0
	event-listener@5.2.0
	exr@1.72.0
	extended@0.1.0
	fallible-iterator@0.3.0
	fallible-streaming-iterator@0.1.9
	fastrand@2.0.1
	fdeflate@0.3.4
	figment@0.10.15
	fixedbitset@0.4.2
	flate2@1.0.28
	flexi_logger@0.28.0
	flume@0.11.0
	fnv@1.0.7
	foreign-types-macros@0.2.3
	foreign-types-shared@0.1.1
	foreign-types-shared@0.3.1
	foreign-types@0.3.2
	foreign-types@0.5.0
	form_urlencoded@1.2.1
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	futures@0.3.30
	gethostname@0.4.3
	getrandom@0.2.12
	gif@0.13.1
	gimli@0.28.1
	gio-sys@0.19.0
	glib-macros@0.19.2
	glib-sys@0.19.0
	glib@0.19.2
	glob@0.3.1
	gobject-sys@0.19.0
	gstreamer-sys@0.22.2
	gstreamer@0.22.2
	h2@0.3.25
	half@2.4.0
	hard-xml-derive@1.36.0
	hard-xml@1.36.0
	hashbrown@0.12.3
	hashbrown@0.14.3
	hashlink@0.9.0
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.3.9
	hex@0.4.3
	home@0.5.9
	http-body@0.4.6
	http@0.2.12
	httparse@1.8.0
	httpdate@1.0.3
	hyper-rustls@0.24.2
	hyper-timeout@0.4.1
	hyper-tls@0.5.0
	hyper@0.14.28
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	icrate@0.0.4
	id3@1.13.1
	ident_case@1.0.1
	idna@0.3.0
	idna@0.5.0
	image@0.24.9
	include_dir@0.7.3
	include_dir_macros@0.7.3
	indexmap@1.9.3
	indexmap@2.2.5
	ipnet@2.9.0
	is-terminal@0.4.12
	itertools@0.11.0
	itertools@0.12.1
	itoa@1.0.10
	jetscii@0.5.3
	jni-sys@0.3.0
	jni@0.21.1
	jobserver@0.1.28
	jpeg-decoder@0.3.1
	js-sys@0.3.69
	lazy-regex-proc_macros@2.4.1
	lazy-regex@2.5.0
	lazy_static@1.4.0
	lazycell@1.3.0
	lebe@0.5.2
	libaes@0.7.0
	libc@0.2.153
	libdbus-sys@0.2.5
	libloading@0.8.3
	libmpv-sirno@2.0.2-fork.1
	libmpv-sys-sirno@2.0.0-fork.1
	libredox@0.0.1
	libredox@0.0.2
	libsqlite3-sys@0.28.0
	linked-hash-map@0.5.6
	linux-raw-sys@0.4.13
	lock_api@0.4.11
	lofty@0.18.2
	lofty_attr@0.9.0
	log@0.4.21
	mach2@0.4.2
	malloc_buf@0.0.6
	matchit@0.7.3
	md5@0.7.0
	mediatype@0.19.18
	memchr@2.7.1
	memmap2@0.9.4
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.2
	mio@0.8.11
	muldiv@1.0.1
	multimap@0.8.3
	native-tls@0.2.11
	ndk-context@0.1.1
	ndk-sys@0.5.0+25.2.9519653
	ndk@0.8.0
	never@0.1.0
	nix@0.28.0
	nom@7.1.3
	ntapi@0.4.1
	nu-ansi-term@0.49.0
	num-bigint@0.4.4
	num-conv@0.1.0
	num-derive@0.4.2
	num-integer@0.1.46
	num-rational@0.4.1
	num-traits@0.2.18
	num_cpus@1.16.0
	num_enum@0.7.2
	num_enum_derive@0.7.2
	objc-sys@0.3.2
	objc2-encode@3.0.0
	objc2@0.4.1
	objc@0.2.7
	object@0.32.2
	oboe-sys@0.6.1
	oboe@0.6.1
	ogg_pager@0.6.0
	once_cell@1.19.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-sys@0.9.101
	openssl@0.10.64
	opml@1.1.6
	option-ext@0.2.0
	option-operations@0.5.0
	orange-trees@0.1.0
	orbclient@0.3.47
	owned_ttf_parser@0.20.0
	parking@2.2.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	paste@1.0.14
	pathdiff@0.2.1
	percent-encoding@2.3.1
	petgraph@0.6.4
	pin-project-internal@1.1.5
	pin-project-lite@0.2.13
	pin-project@1.1.5
	pin-utils@0.1.0
	pinyin@0.10.0
	pkg-config@0.3.30
	png@0.17.13
	polling@3.5.0
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	pretty_assertions@1.4.0
	prettyplease@0.2.16
	proc-macro-crate@3.1.0
	proc-macro2@1.0.79
	prost-build@0.12.3
	prost-derive@0.12.3
	prost-types@0.12.3
	prost@0.12.3
	psl-types@2.0.11
	publicsuffix@2.2.3
	qoi@0.4.1
	quick-xml@0.30.0
	quick-xml@0.31.0
	quote@1.0.35
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rangemap@1.5.1
	raw-window-handle@0.6.0
	rayon-core@1.12.1
	rayon@1.9.0
	redox_syscall@0.3.5
	redox_syscall@0.4.1
	redox_users@0.4.4
	regex-automata@0.4.6
	regex-syntax@0.8.2
	regex@1.10.3
	reqwest@0.11.26
	rfc822_sanitizer@0.3.6
	rgb@0.8.37
	ring@0.17.8
	rss@2.0.7
	rusqlite@0.31.0
	rustc-demangle@0.1.23
	rustc-hash@1.1.0
	rustix@0.38.31
	rustls-pemfile@1.0.4
	rustls-webpki@0.101.7
	rustls@0.21.10
	rustversion@1.0.14
	ryu@1.0.17
	same-file@1.0.6
	sanitize-filename@0.5.0
	schannel@0.1.23
	scoped-tls@1.0.1
	scopeguard@1.2.0
	sct@0.7.1
	sctk-adwaita@0.8.1
	security-framework-sys@2.9.1
	security-framework@2.9.2
	semver@1.0.22
	serde@1.0.197
	serde_derive@1.0.197
	serde_json@1.0.114
	serde_spanned@0.6.5
	serde_urlencoded@0.7.1
	shellexpand@3.1.0
	shlex@1.3.0
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.1
	signal-hook@0.3.17
	simd-adler32@0.3.7
	slab@0.4.9
	smallvec@1.13.1
	smawk@0.3.2
	smithay-client-toolkit@0.18.1
	smol_str@0.2.1
	socket2@0.5.6
	souvlaki@0.7.3
	spin@0.9.8
	stream-download@0.5.0
	strict-num@0.1.1
	strsim@0.10.0
	strsim@0.11.0
	symphonia-bundle-flac@0.5.4
	symphonia-bundle-mp3@0.5.4
	symphonia-codec-aac@0.5.4
	symphonia-codec-adpcm@0.5.4
	symphonia-codec-alac@0.5.4
	symphonia-codec-pcm@0.5.4
	symphonia-codec-vorbis@0.5.4
	symphonia-core@0.5.4
	symphonia-format-isomp4@0.5.4
	symphonia-format-mkv@0.5.4
	symphonia-format-ogg@0.5.4
	symphonia-format-riff@0.5.4
	symphonia-metadata@0.5.4
	symphonia-utils-xiph@0.5.4
	symphonia@0.5.4
	syn@1.0.109
	syn@2.0.53
	sync_wrapper@0.1.2
	sysinfo@0.30.7
	system-configuration-sys@0.5.0
	system-configuration@0.5.1
	system-deps@6.2.1
	tap@1.0.1
	target-lexicon@0.12.14
	tempfile@3.10.1
	termcolor@1.4.1
	textwrap@0.15.2
	textwrap@0.16.1
	thiserror-impl@1.0.58
	thiserror@1.0.58
	tiff@0.9.1
	time-core@0.1.2
	time-macros@0.2.17
	time@0.3.34
	tiny-skia-path@0.11.4
	tiny-skia@0.11.4
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-io-timeout@1.2.0
	tokio-macros@2.2.0
	tokio-native-tls@0.3.1
	tokio-rustls@0.24.1
	tokio-stream@0.1.15
	tokio-util@0.7.10
	tokio@1.36.0
	toml@0.8.11
	toml_datetime@0.6.5
	toml_edit@0.21.1
	toml_edit@0.22.7
	tonic-build@0.11.0
	tonic@0.11.0
	tower-layer@0.3.2
	tower-service@0.3.2
	tower@0.4.13
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	try-lock@0.2.5
	ttf-parser@0.20.0
	tui-realm-stdlib@1.2.0
	tui-realm-treeview@1.1.0
	tui@0.19.0
	tuirealm@1.8.0
	tuirealm_derive@1.0.0
	uncased@0.9.10
	unicode-bidi@0.3.15
	unicode-ident@1.0.12
	unicode-linebreak@0.1.5
	unicode-normalization@0.1.23
	unicode-segmentation@1.11.0
	unicode-width@0.1.11
	untrusted@0.9.0
	url@2.5.0
	urlencoding@2.1.3
	utf8parse@0.2.1
	uuid@0.8.2
	vcpkg@0.2.15
	version-compare@0.1.1
	version_check@0.9.4
	viuer@0.7.1
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-futures@0.4.42
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.92
	wasm-streams@0.4.0
	wayland-backend@0.3.3
	wayland-client@0.31.2
	wayland-csd-frame@0.3.0
	wayland-cursor@0.31.1
	wayland-protocols-plasma@0.2.0
	wayland-protocols-wlr@0.2.0
	wayland-protocols@0.31.2
	wayland-scanner@0.31.1
	wayland-sys@0.31.1
	web-sys@0.3.69
	web-time@0.2.4
	webpki-roots@0.25.4
	weezl@0.1.8
	which@4.4.2
	wildmatch@2.3.3
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-core@0.54.0
	windows-result@0.1.0
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows-targets@0.52.4
	windows@0.44.0
	windows@0.52.0
	windows@0.54.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.4
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.4
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.4
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.4
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.4
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.4
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.4
	winit@0.29.15
	winnow@0.5.40
	winnow@0.6.5
	winreg@0.50.0
	x11-dl@2.21.0
	x11rb-protocol@0.13.0
	x11rb@0.13.0
	xcursor@0.3.5
	xkbcommon-dl@0.4.2
	xkeysym@0.2.0
	xmlparser@0.13.6
	yaml-rust@0.4.5
	yansi@0.5.1
	ytd-rs@0.1.7
	zerocopy-derive@0.7.32
	zerocopy@0.7.32
	zune-inflate@0.2.54
"

inherit cargo

DESCRIPTION="Terminal Music and Podcast Player written in Rust"
HOMEPAGE="https://github.com/tramhao/termusic"
SRC_URI="
	https://github.com/tramhao/termusic/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD GPL-3+ ISC
	LGPL-2.1 LGPL-3+ MIT MPL-2.0 Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+symphonia gst mpv +yt-dlp"
REQUIRED_USE="^^ ( symphonia gst mpv )"
RESTRICT="mirror"

DEPEND="
	symphonia? (
		media-libs/alsa-lib
	)

	gst? (
		dev-libs/glib:2
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
		media-libs/gst-plugins-bad:1.0
		media-libs/gst-plugins-good
		media-libs/gst-plugins-ugly
		media-plugins/gst-plugins-libav
	)
	mpv? (
		media-video/mpv[libmpv]
	)

	dev-libs/protobuf
	sys-apps/dbus
"
RDEPEND="
	${DEPEND}
	yt-dlp? (
		media-video/ffmpeg
		net-misc/yt-dlp
	)
"

src_configure() {
	# default backend is *symphonia*
	# feature gates : *gst* *mpv*
	if use symphonia; then
		local myfeatures=(
			cover
		)
		cargo_src_configure
	else
		local myfeatures=(
			cover
			$(usev gst)
			$(usev mpv)
		)
		cargo_src_configure --no-default-features
	fi
}

src_install() {
	# use 'debug' defined in cargo.eclass
	dobin "target/$(usex debug debug release)/termusic"
	dobin "target/$(usex debug debug release)/termusic-server"

	local DOCS=(
		CHANGELOG.md README.md
	)
	einstalldocs
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		einfo "Configuration files for ${CATEGORY}/${PN} will be"
		einfo "written to \$HOME/.config/${PN} at first launch."
	fi

	einfo "For x11-terms/kitty, album cover support is built in"
	einfo "Using media-gfx/ueberzugpp or media-gfx/ueberzug for other terminals"
}
