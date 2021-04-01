# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV=${PV}.2

inherit unpacker xdg

DESCRIPTION="Baidu Net Disk is a cloud storage client (Linux Version)"
HOMEPAGE="https://pan.baidu.com"
SRC_URI="https://issuecdn.baidupcs.com/issue/netdisk/LinuxGuanjia/${PV}/${PN}_linux_${MY_PV}.deb"

LICENSE=""
SLOT="0"
RESTRICT="strip"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND="x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	dev-libs/nss
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

PATCHES=( "${FILESDIR}" )

src_install() {
	mv usr/share/doc/{${PN},${PF}} || die
	gzip -d usr/share/doc/${PF}/*.gz || die

	insinto /usr
	doins -r usr/share

	insinto /opt
	doins -r opt/${PN}
	fperms +x /opt/${PN}/${PN}

	newbin "${FILESDIR}/${PN}-wrapper.sh" "${PN}"
}
