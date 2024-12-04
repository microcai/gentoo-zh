# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A DNS forwarder"
HOMEPAGE="https://github.com/IrineSistiana/mosdns-cn"
SRC_URI="https://github.com/IrineSistiana/mosdns-cn/releases/download/v${PV}/mosdns-cn-linux-amd64.zip -> ${P}.zip"

S=${WORKDIR}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-alternatives/v2ray-geoip
	app-alternatives/v2ray-geosite
"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"
QA_PREBUILT="
	/usr/bin/mosdns-cn
"

src_install() {
	dobin mosdns-cn

	dosym -r /usr/share/v2ray/geoip.dat /etc/mosdns/geoip.dat
	dosym -r /usr/share/v2ray/geosite.dat /etc/mosdns/geosite.dat

	insinto /etc/mosdns
	newins config-template.yaml config.yaml

	_PN=mosdns-cn
	newinitd "${FILESDIR}/${_PN}.initd" ${_PN}
	newconfd "${FILESDIR}/${_PN}.confd" ${_PN}
}
