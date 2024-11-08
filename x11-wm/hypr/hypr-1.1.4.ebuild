# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake toolchain-funcs

DESCRIPTION="A dynamic Linux tiling window manager for Xorg"
HOMEPAGE="https://github.com/hyprwm/Hypr"
SRC_URI="https://github.com/hyprwm/Hypr/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/Hypr-${PV}"

DEPEND="x11-libs/cairo
		dev-build/ninja
		x11-libs/libxcb
		x11-base/xcb-proto
		x11-libs/xcb-util
		x11-libs/xcb-util-cursor
		x11-libs/xcb-util-keysyms
		x11-libs/xcb-util-wm
		dev-cpp/gtkmm:3.0
		gui-libs/gtk"

pkg_pretend() {
	if ! tc-is-gcc; then
		ewarn "Only GCC is officially supported as compiler"
		ewarn "Proceed with your own caution"
	fi
	}

src_install() {
	dobin "${BUILD_DIR}/Hypr"
	dodoc "${S}/example/hypr.conf"
}
