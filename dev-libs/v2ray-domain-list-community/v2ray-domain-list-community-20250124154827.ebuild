# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Community managed domain list for V2Ray."
HOMEPAGE="https://github.com/v2fly/domain-list-community"
SRC_URI="
	https://github.com/v2fly/domain-list-community/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/blackteahamburger/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz
"

S="${WORKDIR}/domain-list-community-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!dev-libs/v2ray-domain-list-community-bin"
BDEPEND=">=dev-lang/go-1.22"

src_compile() {
	ego run ./
}

src_install() {
	insinto /usr/share/geosite/
	newins dlc.dat v2fly.dat
}
