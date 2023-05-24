# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="Based on the Bilibli offcial client to linux version, support roaming"
HOMEPAGE="https://github.com/msojocs/bilibili-linux"
BASE_URI="https://github.com/msojocs/bilibili-linux/releases/download/v${PV}-1"
FPN="io.github.msojocs.${PN}"
SRC_URI="${BASE_URI}/${FPN}_${PV}-1_amd64.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

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

S="${WORKDIR}"

src_install() {
	insinto "/"
	doins -r "opt"
	doicon -s "scalable" "opt/apps/${FPN}/entries/icons/hicolor/scalable/apps/${FPN}.svg"
	domenu "usr/share/applications/${FPN}.desktop"
	fperms +x "/opt/apps/${FPN}/files/bin/bin/bilibili"
	fperms +x "/opt/apps/${FPN}/files/bin/electron/electron"
}
