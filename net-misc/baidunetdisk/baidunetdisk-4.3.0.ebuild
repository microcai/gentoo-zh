# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="Baidu Net Disk is a cloud storage client (Linux Version)"
HOMEPAGE="https://pan.baidu.com/"
SRC_URI="http://wppkg.baidupcs.com/issue/netdisk/Linuxguanjia/${PV}/${PN}_${PV}_amd64.deb"

LICENSE="BaiduNetDisk"
SLOT="0"
RESTRICT="strip mirror"
KEYWORDS="-* ~amd64"

QA_PREBUILT="*"

RDEPEND="
	app-crypt/p11-kit
	dev-libs/nss
	media-libs/alsa-lib
	x11-libs/gtk+:3[cups]
	x11-libs/libXScrnSaver
	x11-libs/libXtst
"

S="${WORKDIR}"

src_install() {
	insinto /opt
	doins -r opt/"${PN}"
	fperms +x /opt/"${PN}"/"${PN}"
	dosym -r /opt/{"${PN}"/"${PN}",bin/"${PN}"}

	gzip -d usr/share/doc/"${PN}"/*.gz || die
	dodoc usr/share/doc/"${PN}"/*

	domenu usr/share/applications/"${PN}".desktop
	doicon -s scalable usr/share/icons/hicolor/scalable/apps/"${PN}".svg
}
