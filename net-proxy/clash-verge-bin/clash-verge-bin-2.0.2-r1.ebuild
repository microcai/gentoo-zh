# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

DESCRIPTION="(Continuation) of Clash Meta GUI based on Tauri. "
HOMEPAGE="https://github.com/clash-verge-rev/clash-verge-rev"
SRC_URI="
	amd64? (
		https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v${PV}/Clash.Verge_${PV}_amd64.deb
		https://github.com/oatiz/clash-verge-service/releases/download/x86_64-unknown-linux-gnu/clash-verge-service
		https://github.com/oatiz/clash-verge-service/releases/download/x86_64-unknown-linux-gnu/install-service
		https://github.com/oatiz/clash-verge-service/releases/download/x86_64-unknown-linux-gnu/uninstall-service
	)
	arm64? ( https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v${PV}/Clash.Verge_${PV}_arm64.deb )
"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	dev-libs/libayatana-appindicator
	net-libs/webkit-gtk:4.1
	dev-libs/openssl:0/3
"

RDEPEND="${DEPEND}"

src_install(){
	exeinto /opt/clash-verge/bin
	if use amd64; then
		doexe "${S}"/usr/bin/{clash-verge,verge-mihomo,verge-mihomo-alpha}
		doexe "${DISTDIR}"/{clash-verge-service,install-service,uninstall-service}
	else
		dexec "${S}"/usr/bin/*
	fi
	insinto /usr/lib/clash-verge
	doins -r "${S}"/usr/lib/Clash\ Verge/resources
	domenu "${FILESDIR}"/clash-verge.desktop
	doicon -s 128 usr/share/icons/hicolor/128x128/apps/${PN/-bin}.png
	doicon -s 256 usr/share/icons/hicolor/256x256@2/apps/${PN/-bin}.png
	doicon -s 32 usr/share/icons/hicolor/32x32/apps/${PN/-bin}.png
}
