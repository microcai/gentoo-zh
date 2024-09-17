# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Standalone client for Mikrotik routers"
HOMEPAGE="https://mikrotik.com/"
SRC_URI="https://download.mikrotik.com/routeros/winbox/${PV//_}/WinBox_Linux.zip -> ${P}.zip"

S="${WORKDIR}"

LICENSE="MikroTik-EULA"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror strip"

RDEPEND="
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libglvnd
	sys-libs/zlib
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-renderutil
	x11-libs/xcb-util-wm
"
DEPEND="app-arch/unzip"

src_install() {
	dobin WinBox
}
