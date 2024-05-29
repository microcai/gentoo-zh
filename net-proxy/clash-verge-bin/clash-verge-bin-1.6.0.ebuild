# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="(Continuation) of Clash Meta GUI based on Tauri. "
HOMEPAGE="https://github.com/clash-verge-rev/clash-verge-rev"
SRC_URI="
	amd64? ( https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v${PV}/clash-verge_${PV}_amd64.deb )
	arm64? ( https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v${PV}/clash-verge_${PV}_arm64.deb )
"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	dev-libs/libayatana-appindicator
	net-libs/webkit-gtk:4
	net-proxy/mihomo
	dev-libs/openssl:0/3
"

RDEPEND="${DEPEND}"
src_install(){
	dobin "${S}"/usr/bin/clash-verge
	insinto /usr/lib/clash-verge
	doins -r "${S}"/usr/lib/clash-verge/resources
	domenu usr/share/applications/clash-verge.desktop
	doicon -s 128 usr/share/icons/hicolor/128x128/apps/${PN/-bin}.png
	doicon -s 256 usr/share/icons/hicolor/256x256@2/apps/${PN/-bin}.png
	doicon -s 32 usr/share/icons/hicolor/32x32/apps/${PN/-bin}.png
}
