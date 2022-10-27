# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A DNS forwarder"
HOMEPAGE="https://github.com/IrineSistiana/mosdns-cn"
SRC_URI="https://github.com/IrineSistiana/mosdns-cn/releases/download/v{PV}/mosdns-cn-linux-amd64.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/v2ray-domain-list-community-bin"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

S=${WORKDIR}

src_install() {
	dobin mosdns-cn
}
