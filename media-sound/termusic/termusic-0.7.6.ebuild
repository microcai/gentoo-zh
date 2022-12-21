# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	ahash-0.7.6
	aho-corasick-0.7.20
	alsa-0.6.0
	alsa-sys-0.3.1
	ansi_colours-1.2.1
	anyhow-1.0.68
	arrayvec-0.7.2
	autocfg-1.1.0
	base-x-0.2.11
	base64-0.13.1
	bindgen-0.61.0
	bit_field-0.10.1
	bitflags-1.3.2
	block-0.1.6
	bumpalo-3.11.1
	bytemuck-1.12.3
	byteorder-1.4.3
	bytes-1.3.0
	cache-padded-1.2.0
	cassowary-0.3.0
	cc-1.0.78
	cesu8-1.1.0
	cexpr-0.6.0
	cfg-expr-0.11.0
	cfg-if-1.0.0
	chunked_transfer-1.4.0
	clang-sys-1.4.0
	clap-3.2.23
	clap_lex-0.2.4
	cocoa-0.24.1
	cocoa-foundation-0.1.0
	color_quant-1.1.0
	combine-4.6.6
	console-0.15.2
	core-foundation-0.9.3
	core-foundation-sys-0.8.3
	core-graphics-0.22.3
	core-graphics-types-0.1.1
	coreaudio-rs-0.10.0
	coreaudio-sys-0.2.11
	cpal-0.14.2
	crc32fast-1.3.2
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.13
	crossbeam-utils-0.8.14
	crossterm-0.25.0
	crossterm_winapi-0.9.0
	crunchy-0.2.2
	ctor-0.1.26
	cty-0.2.2
	darling-0.13.4
	darling_core-0.13.4
	darling_macro-0.13.4
	dbus-0.9.6
	dbus-crossroads-0.5.1
	diff-0.1.13
	dirs-4.0.0
	dirs-sys-0.3.7
	discard-1.0.4
	discord-rich-presence-0.2.3
	dispatch-0.2.0
	either-1.8.0
	encode_unicode-0.3.6
	encoding_rs-0.8.31
	exr-1.5.2
	fallible-iterator-0.2.0
	fallible-streaming-iterator-0.1.9
	fastrand-1.8.0
	flate2-1.0.25
	flume-0.10.14
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.1.0
	futures-channel-0.3.25
	futures-core-0.3.25
	futures-executor-0.3.25
	futures-macro-0.3.25
	futures-sink-0.3.25
	futures-task-0.3.25
	futures-util-0.3.25
	getrandom-0.2.8
	gif-0.11.4
	gio-sys-0.16.3
	glib-0.16.7
	glib-macros-0.16.3
	glib-sys-0.16.3
	glob-0.3.0
	gobject-sys-0.16.3
	gstreamer-0.19.4
	gstreamer-sys-0.19.4
	half-2.1.0
	hashbrown-0.12.3
	hashlink-0.8.1
	heck-0.4.0
	hermit-abi-0.1.19
	hex-0.4.3
	hound-3.5.0
	id3-1.5.1
	ident_case-1.0.1
	idna-0.3.0
	image-0.24.5
	include_dir-0.7.3
	include_dir_macros-0.7.3
	indexmap-1.9.2
	instant-0.1.12
	itoa-1.0.5
	jni-0.19.0
	jni-sys-0.3.0
	jobserver-0.1.25
	jpeg-decoder-0.3.0
	js-sys-0.3.60
	lazy-regex-2.3.1
	lazy-regex-proc_macros-2.3.1
	lazy_static-1.4.0
	lazycell-1.3.0
	lebe-0.5.2
	lexopt-0.2.1
	libaes-0.6.4
	libc-0.2.138
	libdbus-sys-0.2.2
	libloading-0.7.4
	libmpv-sys-3.1.0
	libsqlite3-sys-0.25.2
	linked-hash-map-0.5.6
	lock_api-0.4.9
	lofty-0.9.0
	lofty_attr-0.4.0
	log-0.4.17
	mach-0.3.2
	malloc_buf-0.0.6
	md5-0.7.0
	memchr-2.5.0
	memoffset-0.6.5
	memoffset-0.7.1
	minimal-lexical-0.2.1
	miniz_oxide-0.6.2
	mio-0.8.5
	muldiv-1.0.1
	nanorand-0.7.0
	ndk-0.6.0
	ndk-0.7.0
	ndk-context-0.1.1
	ndk-glue-0.6.2
	ndk-macro-0.3.0
	ndk-sys-0.3.0
	ndk-sys-0.4.1+23.1.7779620
	nix-0.23.2
	nom-7.1.1
	num-bigint-0.4.3
	num-derive-0.3.3
	num-integer-0.1.45
	num-rational-0.4.1
	num-traits-0.2.15
	num_cpus-1.14.0
	num_enum-0.5.7
	num_enum_derive-0.5.7
	objc-0.2.7
	oboe-0.4.6
	oboe-sys-0.4.5
	ogg_pager-0.3.2
	once_cell-1.16.0
	option-operations-0.5.0
	orange-trees-0.1.0
	os_str_bytes-6.4.1
	output_vt100-0.1.3
	parking_lot-0.12.1
	parking_lot_core-0.9.5
	paste-1.0.11
	peeking_take_while-0.1.2
	percent-encoding-2.2.0
	pin-project-1.0.12
	pin-project-internal-1.0.12
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pinyin-0.9.0
	pkg-config-0.3.26
	png-0.17.7
	ppv-lite86-0.2.17
	pretty-hex-0.3.0
	pretty_assertions-1.3.0
	proc-macro-crate-1.2.1
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.49
	quick-xml-0.26.0
	quote-1.0.23
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	raw-window-handle-0.5.0
	rayon-1.6.1
	rayon-core-1.10.1
	redox_syscall-0.2.16
	redox_users-0.4.3
	regex-1.7.0
	regex-syntax-0.6.28
	remove_dir_all-0.5.3
	rgb-0.8.34
	ring-0.16.20
	ringbuf-0.2.8
	rusqlite-0.28.0
	rustc-hash-1.1.0
	rustc_version-0.2.3
	rustls-0.20.7
	ryu-1.0.12
	same-file-1.0.6
	scoped_threadpool-0.1.9
	scopeguard-1.1.0
	sct-0.7.0
	semver-0.9.0
	semver-parser-0.7.0
	serde-1.0.151
	serde_derive-1.0.151
	serde_json-1.0.91
	sha1-0.6.1
	sha1_smol-1.0.0
	shellexpand-2.1.2
	shlex-1.1.0
	signal-hook-0.3.14
	signal-hook-mio-0.2.3
	signal-hook-registry-1.4.0
	slab-0.4.7
	smallvec-1.10.0
	smawk-0.3.1
	souvlaki-0.5.3
	spin-0.5.2
	spin-0.9.4
	stdweb-0.1.3
	stdweb-0.4.20
	stdweb-derive-0.5.3
	stdweb-internal-macros-0.2.9
	stdweb-internal-runtime-0.1.5
	strsim-0.10.0
	symphonia-0.5.1
	symphonia-bundle-flac-0.5.1
	symphonia-bundle-mp3-0.5.1
	symphonia-codec-aac-0.5.1
	symphonia-codec-alac-0.5.1
	symphonia-codec-pcm-0.5.1
	symphonia-codec-vorbis-0.5.1
	symphonia-core-0.5.1
	symphonia-format-isomp4-0.5.1
	symphonia-format-mkv-0.5.1
	symphonia-format-ogg-0.5.1
	symphonia-format-wav-0.5.1
	symphonia-metadata-0.5.1
	symphonia-utils-xiph-0.5.1
	syn-1.0.107
	system-deps-6.0.3
	tempfile-3.3.0
	termcolor-1.1.3
	terminal_size-0.1.17
	textwrap-0.15.2
	textwrap-0.16.0
	thiserror-1.0.38
	thiserror-impl-1.0.38
	threadpool-1.8.1
	tiff-0.8.1
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	toml-0.5.10
	tui-0.19.0
	tui-realm-stdlib-1.2.0
	tui-realm-treeview-1.1.0
	tuirealm-1.8.0
	tuirealm_derive-1.0.0
	unicode-bidi-0.3.8
	unicode-ident-1.0.6
	unicode-linebreak-0.1.4
	unicode-normalization-0.1.22
	unicode-segmentation-1.10.0
	unicode-width-0.1.10
	untrusted-0.7.1
	ureq-2.5.0
	url-2.3.1
	urlencoding-2.1.2
	uuid-0.8.2
	vcpkg-0.2.15
	version-compare-0.1.1
	version_check-0.9.4
	viuer-0.6.2
	walkdir-2.3.2
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	web-sys-0.3.60
	webpki-0.22.0
	webpki-roots-0.22.6
	weezl-0.1.7
	wildmatch-2.1.1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.37.0
	windows-0.39.0
	windows-sys-0.42.0
	windows_aarch64_gnullvm-0.42.0
	windows_aarch64_msvc-0.37.0
	windows_aarch64_msvc-0.39.0
	windows_aarch64_msvc-0.42.0
	windows_i686_gnu-0.37.0
	windows_i686_gnu-0.39.0
	windows_i686_gnu-0.42.0
	windows_i686_msvc-0.37.0
	windows_i686_msvc-0.39.0
	windows_i686_msvc-0.42.0
	windows_x86_64_gnu-0.37.0
	windows_x86_64_gnu-0.39.0
	windows_x86_64_gnu-0.42.0
	windows_x86_64_gnullvm-0.42.0
	windows_x86_64_msvc-0.37.0
	windows_x86_64_msvc-0.39.0
	windows_x86_64_msvc-0.42.0
	yaml-rust-0.4.5
	yansi-0.5.1
	ytd-rs-0.1.7
"

inherit cargo

DESCRIPTION="Terminal Music Player written in Rust."
HOMEPAGE="https://github.com/tramhao/termusic"

SRC_URI="
	https://github.com/tramhao/termusic/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"
RESTRICT="mirror"

LICENSE="MIT BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 ISC LGPL-3+ MPL-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+symphonia +cover gst +mpris mpv discord +yt-dlp"
REQUIRED_USE="^^ ( symphonia gst mpv )"

DEPEND="
	symphonia? (
		media-libs/alsa-lib
	)
	cover? (
		media-gfx/ueberzug
	)
	mpris? (
		sys-apps/dbus
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
			$(usev cover)
			$(usev mpris)
			$(usev discord)
		)
		cargo_src_configure
	else
		local myfeatures=(
			$(usev cover)
			$(usev mpris)
			$(usev discord)
			$(usev gst)
			$(usev mpv)
		)
		cargo_src_configure --no-default-features
	fi
}

src_install() {
	# Calling *default* here portage will invoke *make install*
	# which install binary into "${HOME}/.local/share/cargo/bin"
	# Instead *cargo_src_install* should be called
	# to properly install binary into "${ED}/usr/bin"
	# pr 1906
	cargo_src_install

	local DOCS=(
		CHANGELOG.md README.md
	)
	einstalldocs
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		einfo "Configuration files for ${CATEGORY}/${PN} will be"
		einfo "written to \$HOME/.config/${PN} at first launch."
		einfo ""
		einfo "You can also manully install themes into"
		einfo " \$HOME/.config/${PN}/themes."
	fi
}
