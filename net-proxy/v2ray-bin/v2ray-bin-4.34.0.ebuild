# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="v${PV}"
inherit systemd

DESCRIPTION="A platform for building proxies to bypass network restrictions."
HOMEPAGE="https://www.v2fly.org"
SRC_URI="
	amd64?	( https://github.com/v2fly/v2ray-core/releases/download/$MY_PV/v2ray-linux-64.zip -> v2ray-$PV-linux-64.zip )
	x86?	( https://github.com/v2fly/v2ray-core/releases/download/$MY_PV/v2ray-linux-32.zip -> v2ray-$PV-linux-32.zip )
	arm?	( https://github.com/v2fly/v2ray-core/releases/download/$MY_PV/v2ray-linux-arm32-v7a.zip -> v2ray-$PV-linux-arm.zip )
	arm?	( https://github.com/v2fly/v2ray-core/releases/download/$MY_PV/v2ray-linux-arm64-v8a.zip -> v2ray-$PV-linux-arm64.zip )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND="!net-proxy/v2ray"
RDEPEND="${DEPEND}"
QA_PRESTRIPPED="
	/usr/bin/v2ray
	/usr/bin/v2ctl
"

src_unpack() {
	if [ -n ${A} ]; then
		unpack ${A}
	fi
	S=${WORKDIR}
}

src_install() {
	dobin v2ray
	dobin v2ctl

	insinto /usr/share/v2ray
	doins *.dat

	insinto /etc/v2ray
	doins *.json

	newinitd "${FILESDIR}/v2ray.initd" v2ray
	systemd_dounit "${FILESDIR}/v2ray.service"
	systemd_newunit "${FILESDIR}/v2ray_at.service" "v2ray@.service"
}
