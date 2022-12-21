# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler-1.0.2
	aho-corasick-0.7.20
	android_system_properties-0.1.5
	anyhow-1.0.68
	async-channel-1.8.0
	atomic_refcell-0.1.8
	atty-0.2.14
	autocfg-1.1.0
	base64-0.20.0
	bitflags-1.3.2
	block-0.1.6
	bumpalo-3.11.1
	bytemuck-1.12.3
	byteorder-1.4.3
	bytes-1.3.0
	cairo-rs-0.16.7
	cairo-sys-rs-0.16.3
	castaway-0.1.2
	cc-1.0.78
	cfg-expr-0.11.0
	cfg-if-1.0.0
	chrono-0.4.23
	codespan-reporting-0.11.1
	color_quant-1.1.0
	concurrent-queue-2.0.0
	cookie-0.16.2
	cookie_store-0.19.0
	core-foundation-sys-0.8.3
	crc32fast-1.3.2
	crossbeam-utils-0.8.14
	curl-0.4.44
	curl-sys-0.4.59+curl-7.86.0
	cxx-1.0.85
	cxx-build-1.0.85
	cxxbridge-flags-1.0.85
	cxxbridge-macro-1.0.85
	dbus-0.6.5
	encoding_rs-0.8.31
	env_logger-0.9.3
	event-listener-2.5.3
	fastrand-1.8.0
	field-offset-0.3.4
	flate2-1.0.25
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
	futures-task-0.3.25
	futures-util-0.3.25
	gdk-pixbuf-0.16.7
	gdk-pixbuf-sys-0.16.3
	gdk4-0.5.4
	gdk4-sys-0.5.4
	getrandom-0.2.8
	gettext-rs-0.7.0
	gettext-sys-0.21.3
	gio-0.16.7
	gio-sys-0.16.3
	glib-0.15.12
	glib-0.16.7
	glib-macros-0.15.11
	glib-macros-0.16.3
	glib-sys-0.15.10
	glib-sys-0.16.3
	gobject-sys-0.15.10
	gobject-sys-0.16.3
	graphene-rs-0.16.3
	graphene-sys-0.16.3
	gsk4-0.5.4
	gsk4-sys-0.5.4
	gstreamer-0.19.4
	gstreamer-base-0.19.3
	gstreamer-base-sys-0.19.3
	gstreamer-play-0.19.4
	gstreamer-play-sys-0.19.2
	gstreamer-sys-0.19.4
	gstreamer-video-0.19.4
	gstreamer-video-sys-0.19.4
	gtk4-0.5.4
	gtk4-macros-0.5.4
	gtk4-sys-0.5.4
	heck-0.4.0
	hermit-abi-0.1.19
	hex-0.4.3
	html-escape-0.2.12
	http-0.2.8
	httpdate-1.0.2
	humantime-2.1.0
	iana-time-zone-0.1.53
	iana-time-zone-haiku-0.1.1
	idna-0.3.0
	image-0.24.5
	instant-0.1.12
	isahc-1.7.2
	itoa-1.0.5
	js-sys-0.3.60
	lazy_static-1.4.0
	libadwaita-0.2.1
	libadwaita-sys-0.2.1
	libc-0.2.138
	libdbus-sys-0.2.2
	libnghttp2-sys-0.1.7+1.45.0
	libz-sys-1.1.8
	link-cplusplus-1.0.8
	locale_config-0.3.0
	log-0.4.17
	malloc_buf-0.0.6
	memchr-2.5.0
	memoffset-0.6.5
	mime-0.3.16
	miniz_oxide-0.6.2
	mpris-player-0.6.2
	muldiv-1.0.1
	num-integer-0.1.45
	num-rational-0.4.1
	num-traits-0.2.15
	objc-0.2.7
	objc-foundation-0.1.1
	objc_id-0.1.1
	once_cell-1.16.0
	openssl-0.10.45
	openssl-macros-0.1.0
	openssl-probe-0.1.5
	openssl-sys-0.9.80
	option-operations-0.5.0
	pango-0.16.5
	pango-sys-0.16.3
	parking-2.0.0
	paste-1.0.11
	percent-encoding-2.2.0
	pest-2.5.1
	pin-project-1.0.12
	pin-project-internal-1.0.12
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pkg-config-0.3.26
	png-0.17.7
	polling-2.5.2
	ppv-lite86-0.2.17
	pretty-hex-0.3.0
	proc-macro-crate-1.2.1
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.49
	psl-types-2.0.11
	publicsuffix-2.2.3
	qrcode-generator-4.1.7
	qrcodegen-1.8.0
	quote-1.0.23
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	regex-1.7.0
	regex-syntax-0.6.28
	rustc_version-0.3.3
	ryu-1.0.12
	schannel-0.1.20
	scratch-1.0.3
	semver-0.11.0
	semver-parser-0.10.2
	serde-1.0.151
	serde_derive-1.0.151
	serde_json-1.0.91
	slab-0.4.7
	sluice-0.5.5
	smallvec-1.10.0
	socket2-0.4.7
	syn-1.0.107
	system-deps-6.0.3
	temp-dir-0.1.11
	termcolor-1.1.3
	thiserror-1.0.38
	thiserror-impl-1.0.38
	time-0.1.45
	time-0.3.17
	time-core-0.1.0
	time-macros-0.2.6
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	toml-0.5.10
	tracing-0.1.37
	tracing-attributes-0.1.23
	tracing-core-0.1.30
	tracing-futures-0.2.5
	ucd-trie-0.1.5
	unicode-bidi-0.3.8
	unicode-ident-1.0.6
	unicode-normalization-0.1.22
	unicode-width-0.1.10
	url-2.3.1
	urlqstring-0.3.5
	utf8-width-0.1.6
	vcpkg-0.2.15
	version-compare-0.1.1
	version_check-0.9.4
	waker-fn-1.1.0
	wasi-0.10.0+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	wepoll-ffi-0.1.2
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.36.1
	windows-sys-0.42.0
	windows_aarch64_gnullvm-0.42.0
	windows_aarch64_msvc-0.36.1
	windows_aarch64_msvc-0.42.0
	windows_i686_gnu-0.36.1
	windows_i686_gnu-0.42.0
	windows_i686_msvc-0.36.1
	windows_i686_msvc-0.42.0
	windows_x86_64_gnu-0.36.1
	windows_x86_64_gnu-0.42.0
	windows_x86_64_gnullvm-0.42.0
	windows_x86_64_msvc-0.36.1
	windows_x86_64_msvc-0.42.0
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
