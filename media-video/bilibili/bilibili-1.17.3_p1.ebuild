# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

MY_PV="${PV/_p/-}"
DESCRIPTION="Based on the Bilibli offcial client to linux version, support roaming"
HOMEPAGE="https://github.com/msojocs/bilibili-linux"
BASE_URI="https://github.com/msojocs/bilibili-linux/releases/download/v${MY_PV}"
FPN="io.github.msojocs.${PN}"
SRC_URI="${BASE_URI}/${FPN}_${MY_PV}_amd64.deb"
S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="wayland"

RDEPEND="
	dev-libs/nss
	media-libs/alsa-lib
	x11-libs/gtk+:*
	x11-libs/libxkbcommon
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libxcb
	x11-misc/xdg-utils
	wayland? ( dev-libs/wayland )
	x11-libs/libvdpau
"

QA_PREBUILT="*"

src_install() {
	insinto "/"
	doins -r "opt"
	doicon -s "scalable" "usr/share/icons/hicolor/scalable/apps/${FPN}.svg"
	domenu "usr/share/applications/${FPN}.desktop"
	fperms +x "/opt/apps/${FPN}/files/bin/bin/bilibili"
	fperms +x "/opt/apps/${FPN}/files/bin/electron/"{electron,chrome_crashpad_handler,chrome-sandbox}
}
