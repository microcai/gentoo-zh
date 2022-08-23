# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	adler32-1.2.0
	aho-corasick-0.7.18
	anyhow-1.0.62
	async-channel-1.7.1
	atty-0.2.14
	autocfg-1.1.0
	base64-0.13.0
	bit_field-0.10.1
	bitflags-1.3.2
	block-0.1.6
	bumpalo-3.11.0
	bytemuck-1.12.1
	byteorder-1.4.3
	bytes-1.2.1
	cache-padded-1.2.0
	cairo-rs-0.15.12
	cairo-sys-rs-0.15.1
	castaway-0.1.2
	cc-1.0.73
	cfg-expr-0.10.3
	cfg-if-1.0.0
	color_quant-1.1.0
	concurrent-queue-1.2.4
	crc32fast-1.3.2
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.10
	crossbeam-utils-0.8.11
	curl-0.4.44
	curl-sys-0.4.56+curl-7.83.1
	dbus-0.6.5
	deflate-1.0.0
	either-1.8.0
	encoding_rs-0.8.31
	env_logger-0.9.0
	event-listener-2.5.3
	exr-1.5.0
	fastrand-1.8.0
	field-offset-0.3.4
	flate2-1.0.24
	flume-0.10.14
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	fragile-1.2.1
	futures-channel-0.3.23
	futures-core-0.3.23
	futures-executor-0.3.23
	futures-io-0.3.23
	futures-lite-1.12.0
	futures-sink-0.3.23
	futures-task-0.3.23
	futures-util-0.3.23
	gdk-pixbuf-0.15.11
	gdk-pixbuf-sys-0.15.10
	gdk4-0.4.8
	gdk4-sys-0.4.8
	getrandom-0.2.7
	gettext-rs-0.7.0
	gettext-sys-0.21.3
	gif-0.11.4
	gio-0.15.12
	gio-sys-0.15.10
	glib-0.15.12
	glib-macros-0.15.11
	glib-sys-0.15.10
	gobject-sys-0.15.10
	graphene-rs-0.15.1
	graphene-sys-0.15.10
	gsk4-0.4.8
	gsk4-sys-0.4.8
	gstreamer-0.18.8
	gstreamer-base-0.18.0
	gstreamer-base-sys-0.18.0
	gstreamer-player-0.18.0
	gstreamer-player-sys-0.18.0
	gstreamer-sys-0.18.0
	gstreamer-video-0.18.7
	gstreamer-video-sys-0.18.3
	gtk4-0.4.8
	gtk4-macros-0.4.8
	gtk4-sys-0.4.8
	half-1.8.2
	heck-0.4.0
	hermit-abi-0.1.19
	hex-0.4.3
	html-escape-0.2.11
	http-0.2.8
	httpdate-1.0.2
	humantime-2.1.0
	idna-0.2.3
	image-0.24.3
	instant-0.1.12
	isahc-1.7.2
	itoa-1.0.3
	jpeg-decoder-0.2.6
	js-sys-0.3.59
	lazy_static-1.4.0
	lebe-0.5.2
	libadwaita-0.1.1
	libadwaita-sys-0.1.0
	libc-0.2.132
	libdbus-sys-0.2.2
	libnghttp2-sys-0.1.7+1.45.0
	libz-sys-1.1.8
	locale_config-0.3.0
	lock_api-0.4.7
	log-0.4.17
	malloc_buf-0.0.6
	matches-0.1.9
	memchr-2.5.0
	memoffset-0.6.5
	mime-0.3.16
	miniz_oxide-0.5.3
	mpris-player-0.6.2
	muldiv-1.0.0
	nanorand-0.7.0
	num-integer-0.1.45
	num-rational-0.4.1
	num-traits-0.2.15
	num_cpus-1.13.1
	objc-0.2.7
	objc-foundation-0.1.1
	objc_id-0.1.1
	once_cell-1.13.1
	openssl-0.10.41
	openssl-macros-0.1.0
	openssl-probe-0.1.5
	openssl-sys-0.9.75
	option-operations-0.4.1
	pango-0.15.10
	pango-sys-0.15.10
	parking-2.0.0
	paste-1.0.8
	percent-encoding-2.1.0
	pest-2.3.0
	pin-project-1.0.12
	pin-project-internal-1.0.12
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pkg-config-0.3.25
	png-0.17.5
	polling-2.3.0
	ppv-lite86-0.2.16
	pretty-hex-0.3.0
	proc-macro-crate-1.2.1
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.43
	qrcode-generator-4.1.6
	qrcodegen-1.8.0
	quick-xml-0.22.0
	quote-1.0.21
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.3
	rayon-1.5.3
	rayon-core-1.9.3
	regex-1.6.0
	regex-syntax-0.6.27
	rustc_version-0.3.3
	ryu-1.0.11
	schannel-0.1.20
	scoped_threadpool-0.1.9
	scopeguard-1.1.0
	semver-0.11.0
	semver-parser-0.10.2
	serde-1.0.144
	serde_derive-1.0.144
	serde_json-1.0.85
	slab-0.4.7
	sluice-0.5.5
	smallvec-1.9.0
	socket2-0.4.4
	spin-0.9.4
	syn-1.0.99
	system-deps-6.0.2
	temp-dir-0.1.11
	termcolor-1.1.3
	thiserror-1.0.32
	thiserror-impl-1.0.32
	threadpool-1.8.1
	tiff-0.7.3
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	toml-0.5.9
	tracing-0.1.36
	tracing-attributes-0.1.22
	tracing-core-0.1.29
	tracing-futures-0.2.5
	ucd-trie-0.1.4
	unicode-bidi-0.3.8
	unicode-ident-1.0.3
	unicode-normalization-0.1.21
	url-2.2.2
	urlqstring-0.3.5
	utf8-width-0.1.6
	vcpkg-0.2.15
	version-compare-0.1.0
	version_check-0.9.4
	waker-fn-1.1.0
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.82
	wasm-bindgen-backend-0.2.82
	wasm-bindgen-macro-0.2.82
	wasm-bindgen-macro-support-0.2.82
	wasm-bindgen-shared-0.2.82
	weezl-0.1.7
	wepoll-ffi-0.1.2
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
"

inherit cargo meson xdg

DESCRIPTION="netease cloud music player based on Rust & GTK for Linux"
HOMEPAGE="https://github.com/gmg137/netease-cloud-music-gtk"
SRC_URI="
	https://github.com/gmg137/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/liuyujielol/vendors/releases/download/${PN}/${P}-deps.tar.gz
	$(cargo_crate_uris ${CRATES})
"

RESTRICT="mirror !test? ( test )"

LICENSE="GPL-3+ Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0 GPL-3 MIT Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+lyrics test"

DEPEND="
	dev-libs/glib:2
	dev-libs/openssl:*
	dev-libs/appstream
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good
	media-libs/gst-plugins-ugly
	media-libs/gstreamer:1.0
	media-plugins/gst-plugins-libav
	media-plugins/gst-plugins-soup
	media-libs/graphene
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	gui-libs/gtk:4
	gui-libs/libadwaita:1
	x11-libs/pango
"
RDEPEND="
	${DEPEND}
	lyrics? (
		media-plugins/osdlyrics
	)
"

src_unpack() {
	cargo_src_unpack
	if [[ -e "${WORKDIR}/cargo_home" ]]; then
		einfo "unpacking vendor"
		mv -v git "${WORKDIR}/cargo_home" || die
	fi
}

src_prepare() {
	local PATCHES=(
		"${FILESDIR}/remove_cargo_home_in_build_env.patch"
		"${FILESDIR}/fix_wrong_metainfo_install_location.patch"
		"${FILESDIR}/dot_desktop_category.patch"
	)
	default
	# generate Cargo.lock needed by meson
	cargo check -r || die
}

src_configure() {
	local emesonargs=(
		-Dlocaledir=share/locale
		-Ddatadir=share
	)
	EMESON_BUILDTYPE=release
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_test() {
	meson_src_test
}

src_install() {
	meson_src_install
}
