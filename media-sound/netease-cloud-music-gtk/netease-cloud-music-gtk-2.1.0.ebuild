# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	aho-corasick-0.7.19
	anyhow-1.0.66
	async-channel-1.7.1
	atomic_refcell-0.1.8
	atty-0.2.14
	autocfg-1.1.0
	base64-0.13.1
	bit_field-0.10.1
	bitflags-1.3.2
	block-0.1.6
	bumpalo-3.11.1
	bytemuck-1.12.3
	byteorder-1.4.3
	bytes-1.2.1
	cache-padded-1.2.0
	cairo-rs-0.16.1
	cairo-sys-rs-0.16.0
	castaway-0.1.2
	cc-1.0.76
	cfg-expr-0.11.0
	cfg-if-1.0.0
	color_quant-1.1.0
	concurrent-queue-1.2.4
	cookie-0.16.1
	cookie_store-0.19.0
	crc32fast-1.3.2
	crossbeam-channel-0.5.6
	crossbeam-deque-0.8.2
	crossbeam-epoch-0.9.11
	crossbeam-utils-0.8.12
	crunchy-0.2.2
	curl-0.4.44
	curl-sys-0.4.59+curl-7.86.0
	dbus-0.6.5
	either-1.8.0
	encoding_rs-0.8.31
	env_logger-0.9.3
	event-listener-2.5.3
	exr-1.5.2
	fastrand-1.8.0
	field-offset-0.3.4
	flate2-1.0.24
	flume-0.10.14
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.1.0
	futures-channel-0.3.25
	futures-core-0.3.25
	futures-executor-0.3.25
	futures-io-0.3.25
	futures-lite-1.12.0
	futures-macro-0.3.25
	futures-sink-0.3.25
	futures-task-0.3.25
	futures-util-0.3.25
	gdk-pixbuf-0.16.0
	gdk-pixbuf-sys-0.16.0
	gdk4-0.5.0
	gdk4-sys-0.5.0
	getrandom-0.2.8
	gettext-rs-0.7.0
	gettext-sys-0.21.3
	gif-0.11.4
	gio-0.16.2
	gio-sys-0.16.0
	glib-0.15.12
	glib-0.16.2
	glib-macros-0.15.11
	glib-macros-0.16.0
	glib-sys-0.15.10
	glib-sys-0.16.0
	gobject-sys-0.15.10
	gobject-sys-0.16.0
	graphene-rs-0.16.0
	graphene-sys-0.16.0
	gsk4-0.5.0
	gsk4-sys-0.5.0
	gstreamer-0.19.1
	gstreamer-base-0.19.1
	gstreamer-base-sys-0.19.0
	gstreamer-play-0.19.0
	gstreamer-play-sys-0.19.0
	gstreamer-sys-0.19.0
	gstreamer-video-0.19.0
	gstreamer-video-sys-0.19.0
	gtk4-0.5.1
	gtk4-macros-0.5.0
	gtk4-sys-0.5.0
	half-2.1.0
	heck-0.4.0
	hermit-abi-0.1.19
	hex-0.4.3
	html-escape-0.2.12
	http-0.2.8
	httpdate-1.0.2
	humantime-2.1.0
	idna-0.3.0
	image-0.24.4
	instant-0.1.12
	isahc-1.7.2
	itoa-1.0.4
	jpeg-decoder-0.2.6
	js-sys-0.3.60
	lazy_static-1.4.0
	lebe-0.5.2
	libadwaita-0.2.0
	libadwaita-sys-0.2.0
	libc-0.2.137
	libdbus-sys-0.2.2
	libnghttp2-sys-0.1.7+1.45.0
	libz-sys-1.1.8
	locale_config-0.3.0
	lock_api-0.4.9
	log-0.4.17
	malloc_buf-0.0.6
	memchr-2.5.0
	memoffset-0.6.5
	mime-0.3.16
	miniz_oxide-0.5.4
	miniz_oxide-0.6.2
	mpris-player-0.6.2
	muldiv-1.0.1
	nanorand-0.7.0
	num-integer-0.1.45
	num-rational-0.4.1
	num-traits-0.2.15
	num_cpus-1.14.0
	objc-0.2.7
	objc-foundation-0.1.1
	objc_id-0.1.1
	once_cell-1.16.0
	openssl-0.10.42
	openssl-macros-0.1.0
	openssl-probe-0.1.5
	openssl-sys-0.9.77
	option-operations-0.5.0
	pango-0.16.0
	pango-sys-0.16.0
	parking-2.0.0
	paste-1.0.9
	percent-encoding-2.2.0
	pest-2.4.1
	pin-project-1.0.12
	pin-project-internal-1.0.12
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pkg-config-0.3.26
	png-0.17.7
	polling-2.4.0
	ppv-lite86-0.2.17
	pretty-hex-0.3.0
	proc-macro-crate-1.2.1
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.47
	psl-types-2.0.11
	publicsuffix-2.2.3
	qrcode-generator-4.1.6
	qrcodegen-1.8.0
	quote-1.0.21
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	rayon-1.5.3
	rayon-core-1.9.3
	regex-1.7.0
	regex-syntax-0.6.28
	rustc_version-0.3.3
	ryu-1.0.11
	schannel-0.1.20
	scoped_threadpool-0.1.9
	scopeguard-1.1.0
	semver-0.11.0
	semver-parser-0.10.2
	serde-1.0.147
	serde_derive-1.0.147
	serde_json-1.0.87
	slab-0.4.7
	sluice-0.5.5
	smallvec-1.10.0
	socket2-0.4.7
	spin-0.9.4
	syn-1.0.103
	system-deps-6.0.3
	temp-dir-0.1.11
	termcolor-1.1.3
	thiserror-1.0.37
	thiserror-impl-1.0.37
	threadpool-1.8.1
	tiff-0.7.4
	time-0.3.17
	time-core-0.1.0
	time-macros-0.2.6
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	toml-0.5.9
	tracing-0.1.37
	tracing-attributes-0.1.23
	tracing-core-0.1.30
	tracing-futures-0.2.5
	ucd-trie-0.1.5
	unicode-bidi-0.3.8
	unicode-ident-1.0.5
	unicode-normalization-0.1.22
	url-2.3.1
	urlqstring-0.3.5
	utf8-width-0.1.6
	vcpkg-0.2.15
	version-compare-0.1.1
	version_check-0.9.4
	waker-fn-1.1.0
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
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

inherit cargo meson xdg gnome2-utils

DESCRIPTION="netease cloud music player based on Rust & GTK for Linux"
HOMEPAGE="https://github.com/gmg137/netease-cloud-music-gtk"
SRC_URI="
	https://github.com/gmg137/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/liuyujielol/vendors/releases/download/${PN}/${P}-deps.tar.xz
	$(cargo_crate_uris ${CRATES})
"

RESTRICT="mirror !test? ( test )"

LICENSE="GPL-3+ Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0 GPL-3 MIT Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

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
		"${FILESDIR}/${PN}-2.0.3-fix-wrong-metainfo-install-location.patch"
	)
	default
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

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
	gnome2_gdk_pixbuf_update
	gnome2_giomodule_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
	gnome2_giomodule_cache_update
}
