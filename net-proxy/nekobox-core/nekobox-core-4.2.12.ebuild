# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Qt based Desktop cross-platform GUI proxy configuration manager"
HOMEPAGE="https://github.com/Mahdi-zarei/nekoray"
SRC_URI="https://github.com/Mahdi-zarei/nekoray/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		https://codeberg.org/G-two/vendor/raw/branch/main/${P}-deps.tar.xz"

S="${WORKDIR}/nekoray-${PV}/core/server"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build \
		-tags "with_clash_api,with_gvisor,with_quic,with_wireguard,with_utls,with_ech,with_dhcp" \
		-ldflags "-X 'github.com/sagernet/sing-box/constant.Version=${PV}'"
}

src_install() {
	exeinto /usr/lib/nekoray/
	doexe nekobox_core
}
