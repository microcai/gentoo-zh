# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd go-module

DESCRIPTION="A platform for building proxies to bypass network restrictions."
HOMEPAGE="https://www.v2fly.org/"
SRC_URI="
	https://github.com/v2fly/v2ray-core/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/liuyujielol/gentoo-go-deps/releases/download/${P}/${P}-deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	!net-proxy/v2ray-bin
	app-alternatives/v2ray-geoip
	app-alternatives/v2ray-geosite"
BDEPEND=">=dev-lang/go-1.20.8"

S="${WORKDIR}/${PN}-core-${PV}"

src_prepare() {
	sed -i 's|/usr/local/bin|/usr/bin|;s|/usr/local/etc|/etc|' release/config/systemd/system/*.service || die
	sed -i '/^User=/s/nobody/v2ray/;/^User=/aDynamicUser=true' release/config/systemd/system/*.service || die
	default
}

src_compile() {
	ego build -v -work -o "bin/v2ray" -trimpath -ldflags "-s -w" ./main
}

src_install() {
	dobin bin/v2ray

	insinto /etc/v2ray
	doins release/config/*.json

	newinitd "${FILESDIR}/v2ray.initd-r1" v2ray
	systemd_newunit release/config/systemd/system/v2ray.service v2ray.service
	systemd_newunit release/config/systemd/system/v2ray@.service v2ray@.service
}
