# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.6.3

EAPI=8

CRATES="
	ahash@0.8.6
	aho-corasick@1.1.2
	allocator-api2@0.2.16
	alphanumeric-sort@1.5.1
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	ansi-to-tui@3.1.0
	anstream@0.6.4
	anstyle-parse@0.2.2
	anstyle-query@1.0.0
	anstyle-wincon@3.0.1
	anstyle@1.0.4
	autocfg@1.1.0
	bitflags@1.3.2
	bitflags@2.4.1
	bstr@1.8.0
	bumpalo@3.14.0
	cassowary@0.3.0
	cc@1.0.83
	cfg-if@1.0.0
	chrono@0.4.31
	clap@4.4.8
	clap_builder@4.4.8
	clap_complete@4.4.4
	clap_derive@4.4.7
	clap_lex@0.6.0
	clipboard-win@4.5.0
	colorchoice@1.0.0
	colors-transform@0.2.11
	core-foundation-sys@0.8.4
	crossbeam-channel@0.5.8
	crossbeam-utils@0.8.16
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	dirs-sys@0.4.1
	dirs@5.0.1
	either@1.9.0
	endian-type@0.1.2
	equivalent@1.0.1
	errno@0.3.7
	error-code@2.3.1
	fd-lock@3.0.13
	filetime@0.2.22
	fnv@1.0.7
	fsevent-sys@4.1.0
	getrandom@0.2.11
	globset@0.4.13
	hashbrown@0.14.2
	heck@0.4.1
	home@0.5.5
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.58
	indexmap@2.1.0
	indoc@2.0.4
	inotify-sys@0.1.5
	inotify@0.9.6
	is-docker@0.2.0
	is-wsl@0.4.0
	itertools@0.11.0
	js-sys@0.3.65
	kqueue-sys@1.0.4
	kqueue@1.0.8
	lazy_static@1.4.0
	libc@0.2.150
	libredox@0.0.1
	libredox@0.0.2
	linux-raw-sys@0.4.11
	log@0.4.20
	lru@0.12.0
	memchr@2.6.4
	minimal-lexical@0.2.1
	mio@0.8.9
	nibble_vec@0.1.0
	nix@0.26.4
	nix@0.27.1
	nom@7.1.3
	notify@6.1.1
	num-traits@0.2.17
	numtoa@0.1.0
	once_cell@1.18.0
	open@5.0.0
	option-ext@0.2.0
	os_str_bytes@6.6.1
	paste@1.0.14
	pathdiff@0.2.1
	phf@0.11.2
	phf_generator@0.11.2
	phf_macros@0.11.2
	phf_shared@0.11.2
	ppv-lite86@0.2.17
	proc-macro2@1.0.69
	quote@1.0.33
	radix_trie@0.2.1
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	ratatui@0.24.0
	redox_syscall@0.3.5
	redox_syscall@0.4.1
	redox_termios@0.1.3
	redox_users@0.4.4
	regex-automata@0.4.3
	regex-syntax@0.8.2
	regex@1.10.2
	rustix@0.38.25
	rustversion@1.0.14
	rustyline@12.0.0
	same-file@1.0.6
	scopeguard@1.2.0
	serde@1.0.192
	serde_derive@1.0.192
	serde_spanned@0.6.4
	shell-words@1.1.0
	shellexpand@3.1.0
	signal-hook-registry@1.4.1
	signal-hook@0.3.17
	siphasher@0.3.11
	smallvec@1.11.2
	str-buf@1.0.6
	strsim@0.10.0
	strum@0.25.0
	strum_macros@0.25.3
	syn@2.0.39
	termion@2.0.3
	thiserror-impl@1.0.50
	thiserror@1.0.50
	toml@0.8.8
	toml_datetime@0.6.5
	toml_edit@0.21.0
	unicode-ident@1.0.12
	unicode-segmentation@1.10.1
	unicode-width@0.1.11
	utf8parse@0.2.1
	uuid-macro-internal@1.6.1
	uuid@1.6.1
	version_check@0.9.4
	walkdir@2.4.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.88
	wasm-bindgen-macro-support@0.2.88
	wasm-bindgen-macro@0.2.88
	wasm-bindgen-shared@0.2.88
	wasm-bindgen@0.2.88
	web-sys@0.3.65
	whoami@1.4.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.51.1
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	winnow@0.5.19
	xdg@2.5.2
	zerocopy-derive@0.7.26
	zerocopy@0.7.26
	${PN}@${PV}
"

inherit cargo

DESCRIPTION="Terminal file manager inspired by ranger"
HOMEPAGE="https://github.com/kamiyaa/joshuto"
SRC_URI=" ${CARGO_CRATE_URIS} "

LICENSE="LGPL-3"
# Dependent crate licenses
LICENSE+="
	Boost-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016
	|| ( Artistic-2 CC0-1.0 )
"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="X wayland +fzf"

RDEPEND="
	fzf? ( app-shells/fzf )
	wayland? ( gui-apps/wl-clipboard )
	X? (
		x11-misc/xclip
		x11-misc/xsel
	)
"

RESTRICT="mirror"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_compile() {
	# project set strip=true in [profile.release]
	# portage complains: QA Notice: Pre-stripped files found
	# let portage do the strip
	export CARGO_PROFILE_RELEASE_STRIP=false
	cargo_src_compile
}

pkg_postinst() {
	elog ""
	elog "For proper devicons support, correct patched font is needed"
	elog "For example:"
	elog "https://github.com/ryanoasis/nerd-fonts"
	elog "or media-fonts/nerd-fonts"
	elog ""
}