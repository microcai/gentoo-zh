# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.25.1
	adler2@2.0.1
	aho-corasick@1.1.4
	anstream@0.6.21
	anstyle-parse@0.2.7
	anstyle-query@1.1.5
	anstyle-wincon@3.0.11
	anstyle@1.0.13
	anyhow@1.0.100
	async-channel@2.5.0
	autocfg@1.5.0
	backtrace@0.3.76
	bitflags@2.10.0
	block@0.1.6
	bumpalo@3.19.0
	byteorder@1.5.0
	cairo-rs@0.21.2
	cairo-sys-rs@0.21.2
	cc@1.2.46
	cfg-expr@0.20.4
	cfg-if@1.0.4
	cfg_aliases@0.2.1
	clap@4.5.51
	clap_builder@4.5.51
	clap_derive@4.5.49
	clap_lex@0.7.6
	colorchoice@1.0.4
	concurrent-queue@2.5.0
	const-random-macro@0.1.16
	const-random@0.1.18
	convert_case@0.6.0
	crossbeam-utils@0.8.21
	crunchy@0.2.4
	darling@0.20.11
	darling_core@0.20.11
	darling_macro@0.20.11
	diff@0.1.13
	dlv-list@0.5.2
	either@1.15.0
	env_logger@0.10.2
	equivalent@1.0.2
	errno-dragonfly@0.1.2
	errno@0.2.8
	event-listener-strategy@0.5.4
	event-listener@5.4.1
	field-offset@0.3.6
	find-msvc-tools@0.1.5
	fnv@1.0.7
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	gdk-pixbuf-sys@0.21.2
	gdk-pixbuf@0.21.2
	gdk4-sys@0.10.1
	gdk4@0.10.1
	getrandom@0.2.16
	gettext-rs@0.7.7
	gettext-sys@0.26.0
	gimli@0.32.3
	gio-sys@0.21.2
	gio@0.21.4
	glib-macros@0.21.4
	glib-sys@0.21.2
	glib@0.21.4
	glob@0.3.3
	gobject-sys@0.21.2
	graphene-rs@0.21.2
	graphene-sys@0.21.2
	gsk4-sys@0.10.1
	gsk4@0.10.1
	gtk4-macros@0.10.1
	gtk4-sys@0.10.1
	gtk4@0.10.2
	hashbrown@0.14.5
	hashbrown@0.16.0
	heck@0.5.0
	hermit-abi@0.5.2
	humantime@2.3.0
	ident_case@1.0.1
	indexmap@2.12.0
	is-terminal@0.4.17
	is_terminal_polyfill@1.70.2
	js-sys@0.3.82
	kernel32-sys@0.2.2
	kinded@0.3.0
	kinded_macros@0.3.0
	lazy-regex-proc_macros@3.4.2
	lazy-regex@3.4.2
	lazy_static@1.5.0
	libadwaita-sys@0.8.0
	libadwaita@0.8.0
	libc@0.2.177
	libloading@0.8.9
	locale_config@0.3.0
	log@0.4.28
	malloc_buf@0.0.6
	memchr@2.7.6
	memoffset@0.9.1
	miniz_oxide@0.8.9
	neli-proc-macros@0.1.4
	neli-wifi@0.6.1
	neli@0.6.5
	nix@0.30.1
	num-traits@0.2.19
	num_cpus@1.17.0
	nutype@0.6.2
	nutype_macros@0.6.2
	nvml-wrapper-sys@0.9.0
	nvml-wrapper@0.11.0
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	object@0.37.3
	once_cell@1.21.3
	once_cell_polyfill@1.70.2
	ordered-multimap@0.7.3
	pango-sys@0.21.2
	pango@0.21.3
	parking@2.2.1
	paste@1.0.15
	path-dedot@3.1.1
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	pkg-config@0.3.32
	plotters-backend@0.3.7
	plotters-cairo@0.8.0
	plotters@0.3.7
	pretty_assertions@1.4.1
	pretty_env_logger@0.5.0
	proc-macro-crate@3.4.0
	proc-macro2@1.0.103
	quote@1.0.42
	regex-automata@0.4.13
	regex-syntax@0.8.8
	regex@1.12.2
	rmp-serde@1.3.0
	rmp@0.8.14
	ron@0.12.0
	rust-ini@0.21.3
	rustc-demangle@0.1.26
	rustc_version@0.4.1
	rustversion@1.0.22
	semver@1.0.27
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_repr@0.1.20
	serde_spanned@1.0.3
	shlex@1.3.0
	slab@0.4.11
	smallvec@1.15.1
	static_assertions@1.1.0
	strsim@0.11.1
	strum@0.27.2
	strum_macros@0.27.2
	syn@1.0.109
	syn@2.0.110
	syscalls@0.7.0
	sysconf@0.3.4
	system-deps@7.0.7
	target-lexicon@0.13.3
	temp-dir@0.1.16
	termcolor@1.4.1
	thiserror-impl@1.0.69
	thiserror-impl@2.0.17
	thiserror@1.0.69
	thiserror@2.0.17
	tiny-keccak@2.0.2
	toml@0.9.8
	toml_datetime@0.7.3
	toml_edit@0.23.7
	toml_parser@1.0.4
	toml_writer@1.0.4
	typeid@1.0.3
	unescape@0.1.0
	unicode-ident@1.0.22
	unicode-segmentation@1.12.0
	urlencoding@2.1.3
	utf8parse@0.2.2
	uzers@0.12.1
	version-compare@0.2.1
	wasi@0.11.1+wasi-snapshot-preview1
	wasm-bindgen-macro-support@0.2.105
	wasm-bindgen-macro@0.2.105
	wasm-bindgen-shared@0.2.105
	wasm-bindgen@0.2.105
	web-sys@0.3.82
	winapi-build@0.1.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.11
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.2.8
	winapi@0.3.9
	windows-link@0.2.1
	windows-sys@0.61.2
	winnow@0.7.13
	wrapcenum-derive@0.4.1
	yansi@1.0.1
"

inherit cargo gnome2 gnome2-utils meson xdg

DESCRIPTION="Keep an eye on system resources"
HOMEPAGE="https://github.com/nokyan/resources"
SRC_URI="https://github.com/nokyan/resources/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="GPL-3+"
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD CC0-1.0 ISC MIT
	Unicode-3.0
"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sys-apps/systemd
	sys-auth/polkit
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/glib
	gui-libs/gtk
	>=gui-libs/libadwaita-1.8.2
"

src_configure () {
	cargo_gen_config
	local emesonargs=("-Dprofile=default")
	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo" || die
}

src_compile () {
	export CARGO_NET_OFFLINE=true
	export CARGO_PROFILE_RELEASE_CODEGEN_UNITS=1
	export CARGO_PROFILE_RELEASE_DEBUG=2
	export CARGO_PROFILE_RELEASE_STRIP=false
	meson_src_compile
}

pkg_postinst () {
	gnome2_schemas_update
}

pkg_postrm () {
	gnome2_schemas_update
}
