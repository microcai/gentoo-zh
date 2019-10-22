# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV="v${PV}"
inherit systemd

DESCRIPTION="A platform for building proxies to bypass network restrictions."
HOMEPAGE="https://www.v2ray.com/"
SRC_URI="
https://github.com/v2ray/v2ray-core/releases/download/${MY_PV}/v2ray-linux-64.zip -> ${PF}.zip
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
RESTRICT="primaryuri strip"
DEPEND=""
S=${WORKDIR}
src_install() {
	dobin v2ray v2ctl

	insinto /etc/v2ray
	doins *.json
	doins geoip.dat geosite.dat

	dodoc doc/readme.md

	newinitd "${FILESDIR}/v2ray.initd" v2ray
	systemd_dounit systemd/v2ray.service
}

pkg_postinst() {
	elog "You may need to add v2ray User&Group for security concerns."
	elog "Then you need to modify the /lib/systemd/system/v2ray.service for systemd user"
	elog "and /etc/init.d/v2ray for openRC user"
}
