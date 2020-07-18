# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg

DESCRIPTION="Baidu Net Disk is a cloud storage client (Linux Version)"
HOMEPAGE="https:/pan.baidu.com"
SRC_URI="http://wppkg.baidupcs.com/issue/netdisk/Linuxguanjia/${PV}/${PN}_${PV}_amd64.deb"

LICENSE=""
SLOT="0"
RESTRICT="strip"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND="x11-libs/gtk+
	x11-libs/libXScrnSaver
	dev-libs/nss
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

src_install() {
	mv usr/share/doc/{${PN},${PF}} || die
	gzip -d usr/share/doc/${PF}/*.gz || die

	insinto /usr
	doins -r usr/share

	insinto /opt
	doins -r opt/${PN}
	fperms +x /opt/${PN}/${PN}
}
