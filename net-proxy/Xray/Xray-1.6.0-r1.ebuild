# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module systemd

DESCRIPTION="Xray, Penetrates Everything."
HOMEPAGE="https://github.com/XTLS/Xray-core"

SRC_URI="https://github.com/XTLS/Xray-core/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/CHN-beta/gentoo-go-dep/releases/download/${P}/${P}-deps.tar.xz"
RESTRICT="mirror"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

BDEPEND=">=dev-lang/go-1.16.2 app-arch/unzip"
RDEPEND="app-misc/ca-certificates app-alternatives/v2ray-geoip app-alternatives/v2ray-geosite"

S="${WORKDIR}/${PN}-core-${PV}"
PATCHES=("${FILESDIR}/Xray-1.5.5-add-v2ray-asset.patch")

src_compile() {
	ego build -v -work -x -o bin/xray -trimpath -ldflags "-buildid=" ./main
}

src_install() {
	dobin bin/xray

	newinitd "${FILESDIR}/xray.initd" xray
	systemd_dounit "${FILESDIR}/xray.service"
	systemd_newunit "${FILESDIR}/xray_at.service" "xray@.service"

	keepdir /etc/xray
}
