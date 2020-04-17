# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="v${PV}"
inherit systemd

DESCRIPTION="A platform for building proxies to bypass network restrictions."
HOMEPAGE="https://www.v2ray.com/"
SRC_URI="
	amd64?	( https://github.com/v2ray/v2ray-core/releases/download/$MY_PV/v2ray-linux-64.zip -> v2ray-$PV-linux-64.zip )
	x86?	( https://github.com/v2ray/v2ray-core/releases/download/$MY_PV/v2ray-linux-32.zip -> v2ray-$PV-linux-32.zip )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	if [ -n ${A} ]; then
		unpack ${A}
	fi
	S=${WORKDIR}
}

src_install() {
	insinto /usr/bin/v2ray
	doins v2ray v2ctl geoip.dat geosite.dat
	fperms 0755 /usr/bin/v2ray/{v2ray,v2ctl,geoip.dat,geosite.dat}

	insinto /etc/v2ray
	doins *.json

	dodoc doc/readme.md

	newinitd "${FILESDIR}/v2ray.initd" v2ray
	systemd_dounit systemd/v2ray.service
	systemd_newunit "${FILESDIR}/v2ray.service" "v2ray@.service"
}
