# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PV="v${PV}"
inherit systemd

DESCRIPTION="A platform for building proxies to bypass network restrictions."
HOMEPAGE="https://www.v2ray.com/"
SRC_URI="
	amd64?	( https://github.com/v2ray/v2ray-core/releases/download/$MY_PV/v2ray-linux-64.zip )
	x86?	( https://github.com/v2ray/v2ray-core/releases/download/$MY_PV/v2ray-linux-32.zip )
	arm?	( https://github.com/v2ray/v2ray-core/releases/download/$MY_PV/v2ray-linux-arm.zip )
	arm64?	( https://github.com/v2ray/v2ray-core/releases/download/$MY_PV/v2ray-linux-arm64.zip )
	mips?	( https://github.com/v2ray/v2ray-core/releases/download/$MY_PV/v2ray-linux-mips64.zip )
	s390?	( https://github.com/v2ray/v2ray-core/releases/download/$MY_PV/v2ray-linux-s390x.zip )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64 ~mips ~s390"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	if [ "${A}" != "" ]; then
		unpack ${A}
	fi
	mv * ${PN}-${PV}
}

src_install() {
	gobindir=`dirname ${S}/*/`
	pushd $gobindir

	dobin v2ray v2ctl

	insinto /etc/v2ray
	doins *.json

	insinto /usr/share/v2ray
	doins geoip.dat geosite.dat

	dodoc readme.md

	newinitd "${FILESDIR}/v2ray.initd" v2ray
	systemd_dounit systemd/v2ray.service

	popd
}

pkg_postinst() {
	elog "You may need to add v2ray User&Group for security concerns."
	elog "Then you need to modify the /lib/systemd/system/v2ray.service for systemd user"
	elog "and /etc/init.d/v2ray for openRC user"
}

