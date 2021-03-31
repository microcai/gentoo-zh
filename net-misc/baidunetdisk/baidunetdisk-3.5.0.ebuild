# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker desktop xdg

DESCRIPTION="Baidu Net Disk is a cloud storage client (Linux Version)"
HOMEPAGE="https://pan.baidu.com/"
SRC_URI="http://wppkg.baidupcs.com/issue/netdisk/Linuxguanjia/${PV}/${PN}_${PV}_amd64.deb"

LICENSE=""
SLOT="0"
RESTRICT="strip"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND="x11-libs/gtk+:3[cups]
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/p11-kit
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

src_install() {
	insinto /opt
	doins -r opt/"${PN}"
	fperms +x /opt/"${PN}"/"${PN}"

	gzip -d usr/share/doc/"${PN}"/*.gz || die
	dodoc usr/share/doc/"${PN}"/*

	domenu usr/share/applications/"${PN}".desktop
	doicon -s scalable usr/share/icons/hicolor/scalable/apps/"${PN}".svg
}
