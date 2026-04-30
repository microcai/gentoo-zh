# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Kyocera printer driver for linux"
HOMEPAGE="https://www.kyoceradocumentsolutions.com.cn/support/mfp/download/"

SRC_URI="
	amd64?	( https://www.kyoceraconnect.com/servlet/kyocera.admin.DownloadServlet?actionType=download&id=1301
				-> KyoceraLinuxPackages-20240521.tar.gz )
"

S="${WORKDIR}"

LICENSE="KYOCERA"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="strip mirror bindist" # mirror as explained at bug #547372

RDEPEND="
	net-print/cups
"

src_unpack() {
	unpack KyoceraLinuxPackages-20240521.tar.gz
	unpack_deb Debian/Global/kyodialog_amd64/kyodialog_${PV}-0_amd64.deb
}

src_install() {
	exeinto /usr/lib/cups/filter
	exeopts -m0755
	doexe "${S}"/usr/lib/cups/filter/*

	# Skip the optional Qt5 GUI; CUPS filters and PPD resources work without it.
	insinto /usr/share
	doins -r "${S}"/usr/share/kyocera9.4
}
