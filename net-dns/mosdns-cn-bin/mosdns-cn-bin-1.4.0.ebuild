# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A DNS forwarder"
HOMEPAGE="https://github.com/IrineSistiana/mosdns-cn"
SRC_URI="https://github.com/IrineSistiana/mosdns-cn/releases/download/v${PV}/mosdns-cn-linux-amd64.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-libs/v2ray-domain-list-community-bin
	dev-libs/v2ray-geoip-bin
"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

S=${WORKDIR}

src_install() {
	dobin mosdns-cn

	insinto /etc/mosdns
	ln -s /usr/share/v2ray/geoip.dat geoip.dat
	ln -s /usr/share/v2ray/geosite.dat geosite.dat
	doins geoip.dat geosite.dat
	newins config-template.yaml config.yaml
	_PN=mosdns-cn
	newinitd "${FILESDIR}/${_PN}.initd" ${_PN}
	newconfd "${FILESDIR}/${_PN}.confd" ${_PN}
}
