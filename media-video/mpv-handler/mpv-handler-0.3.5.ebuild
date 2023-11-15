# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	base64@0.21.3
	bitflags@1.3.2
	cfg@if-1.0.0
	dirs@5.0.1
	dirs@sys-0.4.1
	equivalent@1.0.1
	getrandom@0.2.10
	hashbrown@0.14.0
	indexmap@2.0.0
	libc@0.2.147
	memchr@2.6.3
	option@ext-0.2.0
	proc@macro2-1.0.66
	quote@1.0.33
	redox_syscall@0.2.16
	redox_users@0.4.3
	serde@1.0.188
	serde_derive@1.0.188
	serde_spanned@0.6.3
	syn@2.0.31
	thiserror@1.0.48
	thiserror@impl-1.0.48
	toml@0.7.7
	toml_datetime@0.6.3
	toml_edit@0.19.15
	unicode@ident-1.0.11
	wasi@0.11.0+wasi-snapshot-preview1
	windows@sys-0.48.0
	windows@targets-0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	winnow@0.5.15
"

inherit cargo xdg desktop

DESCRIPTION="A protocol handler for mpv, written by Rust."
HOMEPAGE="https://github.com/akiirui/mpv-handler"
SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/akiirui/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"
KEYWORDS="~amd64"
RESTRICT="strip"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT Unicode-DFS-2016"
SLOT="0"

RDEPEND="
	media-video/mpv
"

src_install() {
	dobin "target/release/mpv-handler"
	dodoc "share/linux/config.toml"
	domenu "share/linux/mpv-handler.desktop"
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "install net-misc/youtube-dl (recommended) or net-misc/yt-dlp"
	elog "to enable mpv to play video and music from the websites."
}
