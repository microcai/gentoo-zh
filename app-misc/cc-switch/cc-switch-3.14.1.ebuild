# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

RUST_MIN_VER="1.88.0"

inherit cargo desktop xdg

DESCRIPTION="All-in-One Assistant for Claude Code, Codex & Gemini CLI"
HOMEPAGE="https://github.com/farion1231/cc-switch"
SRC_URI="
	https://github.com/farion1231/${PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.tar.gz
	https://github.com/liangyongxiang/gentoo-go-deps/releases/download/${P}/${P}-crates.tar.xz
	https://github.com/liangyongxiang/gentoo-go-deps/releases/download/${P}/${P}-node_modules.tar.xz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 CC0-1.0
	CDLA-Permissive-2.0 ISC MIT MPL-2.0 openssl Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

# The tray integration loads libayatana-appindicator at runtime.
DEPEND="
	app-arch/xz-utils
	dev-libs/glib:2
	dev-libs/libayatana-appindicator
	dev-libs/openssl:=
	net-libs/libsoup:3.0
	net-libs/webkit-gtk:4.1
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
"
RDEPEND="
	!app-misc/cc-switch-bin
	${DEPEND}
"
BDEPEND="
	dev-build/cmake
	net-libs/nodejs[npm]
	virtual/pkgconfig
"

# Rust does not use *FLAGS from make.conf; silence Portage warnings.
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_prepare() {
	default

	rm rust-toolchain.toml || die
	sed -i '/^strip = "symbols"/d' src-tauri/Cargo.toml || die
}

src_compile() {
	local -x npm_config_audit=false
	local -x npm_config_color=false
	local -x npm_config_fund=false
	local -x npm_config_update_notifier=false

	local -x CARGO_TARGET_DIR="${WORKDIR}/target"
	cargo_env npm run tauri -- build --ci --no-bundle --ignore-version-mismatches \
		--config "${FILESDIR}"/tauri-gentoo.conf.json -- --frozen --locked || die
}

src_install() {
	local -x CARGO_TARGET_DIR="${WORKDIR}/target"

	dobin "$(cargo_target_dir)/${PN}"
	newicon -s 32 src-tauri/icons/32x32.png com.ccswitch.desktop.png
	newicon -s 64 src-tauri/icons/64x64.png com.ccswitch.desktop.png
	newicon -s 128 src-tauri/icons/128x128.png com.ccswitch.desktop.png
	newicon -s 256 src-tauri/icons/128x128@2x.png com.ccswitch.desktop.png
	domenu flatpak/com.ccswitch.desktop.desktop

	insinto /usr/share/metainfo
	doins flatpak/com.ccswitch.desktop.metainfo.xml

	einstalldocs
}
