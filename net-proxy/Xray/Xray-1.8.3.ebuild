# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Xray, Penetrates Everything. Also the best v2ray-core, with XTLS support."
HOMEPAGE="https://github.com/XTLS/Xray-core"
SRC_URI="https://github.com/XTLS/Xray-core/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Puqns67/gentoo-deps/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	app-alternatives/v2ray-geoip
	app-alternatives/v2ray-geosite"
BDEPEND=">=dev-lang/go-1.19"

S="${WORKDIR}/${PN}-core-${PV}"

src_compile() {
	CGO_ENABLED=0 ego build -v -work -x -o xray -trimpath -ldflags "-s -w -buildid=" ./main
}

src_install() {
	dobin xray
	newinitd "${FILESDIR}/xray.initd" xray
	systemd_dounit "${FILESDIR}/xray.service"
	systemd_dounit "${FILESDIR}/xray_at.service"
	dosym -r /usr/share/v2ray/geosite.dat /usr/share/xray/geosite.dat
	dosym -r /usr/share/v2ray/geoip.dat /usr/share/xray/geoip.dat
	keepdir /etc/xray
}
