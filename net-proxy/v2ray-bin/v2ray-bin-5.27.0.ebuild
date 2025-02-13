# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit systemd

DESCRIPTION="A platform for building proxies to bypass network restrictions"
HOMEPAGE="
	https://www.v2fly.org
	https://github.com/v2fly/v2ray-core
"
SRC_URI="
	amd64? ( https://github.com/v2fly/v2ray-core/releases/download/v${PV}/v2ray-linux-64.zip -> v2ray-${PV}-linux-64.zip )
	x86? ( https://github.com/v2fly/v2ray-core/releases/download/v${PV}/v2ray-linux-32.zip -> v2ray-${PV}-linux-32.zip )
	arm? (
		https://github.com/v2fly/v2ray-core/releases/download/v${PV}/v2ray-linux-arm32-v7a.zip -> v2ray-${PV}-linux-arm.zip
	)
	arm64? (
		https://github.com/v2fly/v2ray-core/releases/download/v${PV}/v2ray-linux-arm64-v8a.zip -> v2ray-${PV}-linux-arm64.zip
	)
"

S=${WORKDIR}

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64 ~x86"

DEPEND="
	app-alternatives/v2ray-geoip
	app-alternatives/v2ray-geosite
"
RDEPEND="
	!net-proxy/v2ray
	${DEPEND}
"
BDEPEND="app-arch/unzip"
QA_PREBUILT="
	/usr/bin/v2ray
"

src_install() {
	dobin v2ray

	insinto /etc/v2ray
	doins *.json

	sed -i 's|/usr/local/bin|/usr/bin|;s|/usr/local/etc|/etc|' systemd/system/*.service || die
	sed -i '/^User=/s/nobody/v2ray/;/^User=/aDynamicUser=true' systemd/system/*.service || die

	newinitd "${FILESDIR}/v2ray.initd-r1" v2ray
	systemd_dounit systemd/system/v2ray.service
	systemd_dounit systemd/system/v2ray@.service
}
