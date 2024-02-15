# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit unpacker xdg
DESCRIPTION="(Continuation) of Clash Meta GUI based on Tauri. "
HOMEPAGE="https://github.com/clash-verge-rev/clash-verge-rev"
SRC_URI="https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v${PV}/clash-verge_${PV}_amd64.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libayatana-appindicator
	net-libs/webkit-gtk:4
	net-proxy/mihomo
	dev-libs/openssl
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"
src_install(){
	exeinto /usr/bin
	exeopts -m0755
	doexe "${S}"/usr/bin/clash-verge
	insinto /usr/lib/clash-verge
	doins -r "${S}"/usr/lib/clash-verge/resources
	insinto /usr/share
	doins -r "${S}"/usr/share/{applications,icons}

}
