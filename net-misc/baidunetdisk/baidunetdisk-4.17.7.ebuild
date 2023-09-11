# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="Baidu Net Disk is a cloud storage client (Linux Version)"
HOMEPAGE="https://pan.baidu.com/"
SRC_URI="http://wppkg.baidupcs.com/issue/netdisk/Linuxguanjia/${PV}/${PN}_${PV}_amd64.deb"

LICENSE="BaiduNetDisk"
SLOT="0"
RESTRICT="strip"
KEYWORDS="-* ~amd64"
IUSE=""

QA_PREBUILT="*"

# libuuid
# libatspi2.0
RDEPEND="
	app-crypt/p11-kit
	app-crypt/libsecret
	dev-libs/nss
	media-libs/alsa-lib
	x11-misc/xdg-utils
	x11-libs/gtk+:3[cups]
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	x11-libs/libXtst
"

S="${WORKDIR}"

src_install() {
	insinto /opt
	doins -r opt/"${PN}"
	fperms +x /opt/"${PN}"/"${PN}"
	dobin "${FILESDIR}"/baidunetdisk

	gzip -d usr/share/doc/"${PN}"/*.gz || die
	dodoc usr/share/doc/"${PN}"/*

	sed -i "s/Exec=.*/Exec=baidunetdisk %U/g" usr/share/applications/"${PN}".desktop
	domenu usr/share/applications/"${PN}".desktop
	doicon -s scalable usr/share/icons/hicolor/scalable/apps/"${PN}".svg
}
