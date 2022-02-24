# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	adler32-1.2.0
	aho-corasick-0.7.18
	alsa-0.6.0
	alsa-sys-0.3.1
	ansi_colours-1.1.1
	ansi_term-0.12.1
	anyhow-1.0.53
	arrayvec-0.7.2
	autocfg-1.1.0
	base64-0.13.0
	bindgen-0.56.0
	bitflags-1.3.2
	bumpalo-3.9.1
	bytemuck-1.7.3
	byteorder-1.4.3
	bytes-1.1.0
	cassowary-0.3.0
	cc-1.0.72
	cesu8-1.1.0
	cexpr-0.4.0
	cfg-expr-0.8.1
	cfg-if-1.0.0
	chunked_transfer-1.4.0
	clang-sys-1.3.1
	color_quant-1.1.0
	combine-4.6.3
	console-0.15.0
	core-foundation-sys-0.8.3
	coreaudio-rs-0.10.0
	coreaudio-sys-0.2.9
	cpal-0.13.5
	crc32fast-1.3.2
	crossbeam-channel-0.5.2
	crossbeam-deque-0.8.1
	crossbeam-epoch-0.9.7
	crossbeam-utils-0.8.7
	crossterm-0.20.0
	crossterm-0.22.1
	crossterm_winapi-0.8.0
	crossterm_winapi-0.9.0
	ctor-0.1.21
	darling-0.13.1
	darling_core-0.13.1
	darling_macro-0.13.1
	dbus-0.9.5
	dbus-crossroads-0.5.0
	deflate-0.8.6
	diff-0.1.12
	dirs-4.0.0
	dirs-next-2.0.0
	dirs-sys-0.3.6
	dirs-sys-next-0.1.2
	either-1.6.1
	encode_unicode-0.3.6
	encoding_rs-0.8.30
	fastrand-1.7.0
	flate2-1.0.22
	fnv-1.0.7
	form_urlencoded-1.0.1
	futures-channel-0.3.21
	futures-core-0.3.21
	futures-executor-0.3.21
	futures-task-0.3.21
	futures-util-0.3.21
	getrandom-0.2.4
	gif-0.11.3
	glib-0.14.8
	glib-macros-0.14.1
	glib-sys-0.14.0
	glob-0.3.0
	gobject-sys-0.14.0
	gstreamer-0.17.4
	gstreamer-audio-sys-0.17.0
	gstreamer-base-0.17.2
	gstreamer-base-sys-0.17.0
	gstreamer-pbutils-0.17.2
	gstreamer-pbutils-sys-0.17.0
	gstreamer-player-0.17.0
	gstreamer-player-sys-0.17.0
	gstreamer-sys-0.17.3
	gstreamer-video-0.17.2
	gstreamer-video-sys-0.17.0
	heck-0.3.3
	hermit-abi-0.1.19
	hex-0.4.3
	id3-0.6.6
	ident_case-1.0.1
	idna-0.2.3
	if_chain-1.0.2
	image-0.23.14
	instant-0.1.12
	itertools-0.10.3
	itoa-1.0.1
	jni-0.19.0
	jni-sys-0.3.0
	jobserver-0.1.24
	jpeg-decoder-0.1.22
	js-sys-0.3.56
	lazy_static-1.4.0
	lazycell-1.3.0
	libaes-0.6.1
	libc-0.2.117
	libdbus-sys-0.2.2
	libloading-0.7.3
	libmpv-2.0.1
	libmpv-sys-3.1.0
	linked-hash-map-0.5.4
	lock_api-0.4.6
	lofty-0.3.3
	log-0.4.14
	mach-0.3.2
	matches-0.1.9
	md5-0.7.0
	memchr-2.4.1
	memoffset-0.6.5
	miniz_oxide-0.3.7
	miniz_oxide-0.4.4
	mio-0.7.14
	miow-0.3.7
	muldiv-1.0.0
	ndk-0.6.0
	ndk-glue-0.6.0
	ndk-macro-0.3.0
	ndk-sys-0.3.0
	nix-0.23.1
	nom-5.1.2
	ntapi-0.3.7
	num-bigint-0.2.6
	num-derive-0.3.3
	num-integer-0.1.44
	num-iter-0.1.42
	num-rational-0.3.2
	num-rational-0.4.0
	num-traits-0.2.14
	num_cpus-1.13.1
	num_enum-0.5.6
	num_enum_derive-0.5.6
	oboe-0.4.5
	oboe-sys-0.4.5
	ogg_pager-0.2.0
	once_cell-1.9.0
	orange-trees-0.1.0
	output_vt100-0.1.2
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	paste-1.0.6
	peeking_take_while-0.1.2
	percent-encoding-2.1.0
	pin-project-lite-0.2.8
	pin-utils-0.1.0
	pinyin-0.8.0
	pkg-config-0.3.24
	png-0.16.8
	ppv-lite86-0.2.16
	pretty-hex-0.2.1
	pretty_assertions-0.7.2
	proc-macro-crate-1.1.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.36
	quote-1.0.15
	rand-0.8.4
	rand_chacha-0.3.1
	rand_core-0.6.3
	rand_hc-0.3.1
	rayon-1.5.1
	rayon-core-1.9.1
	redox_syscall-0.2.10
	redox_users-0.4.0
	regex-1.5.4
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	rgb-0.8.31
	ring-0.16.20
	rustc-hash-1.1.0
	rustls-0.20.2
	ryu-1.0.9
	same-file-1.0.6
	scoped_threadpool-0.1.9
	scopeguard-1.1.0
	sct-0.7.0
	serde-1.0.136
	serde_derive-1.0.136
	serde_json-1.0.78
	shellexpand-2.1.0
	shlex-0.1.1
	signal-hook-0.3.13
	signal-hook-mio-0.2.1
	signal-hook-registry-1.4.0
	slab-0.4.5
	smallvec-1.8.0
	smawk-0.3.1
	spin-0.5.2
	stdweb-0.1.3
	strsim-0.10.0
	strum-0.21.0
	strum_macros-0.21.1
	symphonia-0.5.0
	symphonia-bundle-flac-0.5.0
	symphonia-bundle-mp3-0.5.0
	symphonia-codec-aac-0.5.0
	symphonia-codec-pcm-0.5.0
	symphonia-codec-vorbis-0.5.0
	symphonia-core-0.5.0
	symphonia-format-isomp4-0.5.0
	symphonia-format-mkv-0.5.0
	symphonia-format-ogg-0.5.0
	symphonia-format-wav-0.5.0
	symphonia-metadata-0.5.0
	symphonia-utils-xiph-0.5.0
	syn-1.0.86
	system-deps-3.2.0
	tempfile-3.3.0
	termcolor-1.1.2
	terminal_size-0.1.17
	termusic-0.6.10
	textwrap-0.14.2
	thiserror-1.0.30
	thiserror-impl-1.0.30
	tiff-0.6.1
	tinyvec-1.5.1
	tinyvec_macros-0.1.0
	toml-0.5.8
	tui-0.16.0
	tui-realm-stdlib-1.1.6
	tui-realm-treeview-1.1.0
	tuirealm-1.4.2
	tuirealm_derive-1.0.0
	unicode-bidi-0.3.7
	unicode-linebreak-0.1.2
	unicode-normalization-0.1.19
	unicode-segmentation-1.9.0
	unicode-width-0.1.9
	unicode-xid-0.2.2
	untrusted-0.7.1
	ureq-2.4.0
	url-2.2.2
	version-compare-0.0.11
	version_check-0.9.4
	viuer-0.5.3
	walkdir-2.3.2
	wasi-0.10.2+wasi-snapshot-preview1
	wasm-bindgen-0.2.79
	wasm-bindgen-backend-0.2.79
	wasm-bindgen-macro-0.2.79
	wasm-bindgen-macro-support-0.2.79
	wasm-bindgen-shared-0.2.79
	web-sys-0.3.56
	webpki-0.22.0
	webpki-roots-0.22.2
	weezl-0.1.5
	wildmatch-2.1.0
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	yaml-rust-0.4.5
	ytd-rs-0.1.6
"

inherit cargo multiprocessing

DESCRIPTION="Music Player TUI written in Rust"
HOMEPAGE="https://github.com/tramhao/termusic"

SRC_URI="
	https://github.com/tramhao/termusic/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"
RESTRICT="mirror"

LICENSE="MIT BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 ISC LGPL-3+ MPL-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+symphonia +cover gst +mpris mpv +yt-dlp"
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
		media-libs/gstreamer
		media-libs/gst-plugins-base
		media-libs/gst-plugins-bad
		media-libs/gst-plugins-good
		media-libs/gst-plugins-ugly
		media-plugins/gst-plugins-libav
	)
	mpv? (
		media-video/mpv
	)
"
RDEPEND="
	${DEPEND}
	yt-dlp? (
		media-video/ffmpeg
		net-misc/yt-dlp
	)
"

src_prepare() {
	# Make cargo respect MAKEOPTS
	export CARGO_BUILD_JOBS="$(makeopts_jobs)"

	default
}

src_configure() {
	# default backend is *symphonia*
	# feature gates : *gst* *mpv*
	if use symphonia; then
		local myfeatures=(
			$(usev cover)
			$(usev mpris)
		)
		cargo_src_configure
	else
		local myfeatures=(
			$(usev cover)
			$(usev mpris)
			$(usev gst)
			$(usev mpv)
		)
		cargo_src_configure --no-default-features
	fi
}

src_install() {
	dobin "target/release/${PN}"

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
