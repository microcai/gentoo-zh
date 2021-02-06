# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils desktop

MY_V=$(ver_cut 1-2)
MY_PV=$(ver_rs 3 '_')

DESCRIPTION="NoMachine Enterprise Client"
HOMEPAGE="https://www.nomachine.com"
SRC_URI="https://download.nomachine.com/download/${MY_V}/Linux/${PN}_${MY_PV}_x86_64.tar.gz
	x86? ( https://download.nomachine.com/download/${MY_V}/Linux/${PN}_${MY_PV}_i686.tar.gz )"
S="${WORKDIR}/NX/etc/NX/player/packages"

LICENSE="nomachine"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="strip"

DEPEND=""
BDEPEND=""
RDEPEND="dev-libs/glib:2
		dev-libs/openssl:0"

QA_PREBUILT="*"

src_install() {
	local NXROOT=/opt/NX

	doicon "${FILESDIR}/${PN}.png"
	make_desktop_entry "nxplayer" "NoMachine Enterprise Client" "" "Network"
	dodir /opt
	tar xzof nxclient.tar.gz -C "${D}"/opt
	tar xzof nxplayer.tar.gz -C "${D}"/opt

	make_wrapper nxplayer ${NXROOT}/bin/nxplayer ${NXROOT} ${NXROOT}/lib /opt/bin
}
