# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

NONFATAL_VERIFY=1
inherit go-module systemd

DESCRIPTION="A platform for building proxies to bypass network restrictions."
HOMEPAGE="https://github.com/v2fly/v2ray-core"

SRC_URI="https://github.com/v2fly/v2ray-core/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/rjnd1/v2ray-core-vendor/archive/refs/tags/v${PV}.tar.gz -> ${P}-vendor.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+tool"

BDEPEND="
	>=dev-lang/go-1.19:=
	<dev-lang/go-1.20:="
DEPEND=""
RDEPEND="
	!net-proxy/v2ray-bin
	dev-libs/v2ray-geoip-bin
	|| (
		dev-libs/v2ray-domain-list-community-bin
		dev-libs/v2ray-domain-list-community
	)
"

S="${WORKDIR}/${PN}-core-${PV}"

src_prepare() {
	sed -i 's|/usr/local/bin|/usr/bin|;s|/usr/local/etc|/etc|' release/config/systemd/system/*.service || die
	sed -i '/^User=/s/nobody/v2ray/;/^User=/aDynamicUser=true' release/config/systemd/system/*.service || die
	mv ../${PN}-core-vendor-${PV}/vendor ./ || die
	eapply ../${PN}-core-vendor-${PV}/${PN}-core-${PV}-go-1-19-quic-go.patch
	default
}

src_compile() {
	ego build -mod vendor -v -work -o "bin/v2ray" -trimpath -ldflags "-s -w" ./main
	if use tool; then
		ego build -mod vendor -v -work -o "bin/v2ctl" -trimpath -ldflags "-s -w" -tags confonly ./infra/control/main
	fi
}

src_install() {
	dobin bin/v2ray
	if use tool; then
		dobin bin/v2ctl
	fi

	insinto /etc/v2ray
	doins release/config/*.json

	newinitd "${FILESDIR}/v2ray.initd" v2ray
	systemd_newunit release/config/systemd/system/v2ray.service v2ray.service
	systemd_newunit release/config/systemd/system/v2ray@.service v2ray@.service
}
