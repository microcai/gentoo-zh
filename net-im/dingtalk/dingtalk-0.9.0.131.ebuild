# Copyright 2011-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker desktop

DESCRIPTION="dingtalk"
HOMEPAGE="https://gov.dingtalk.com"

KEYWORDS="-* ~amd64"

DISTFILE_BIN="com.alibabainc.${PN}_${PV}_amd64.deb"
SRC_URI="http://nowhere.to.download/${DISTFILE_BIN}"

LICENSE="dingding"
SLOT="0"
IUSE=""
RESTRICT="bindist strip fetch"

RDEPEND="
	>=sys-libs/glibc-2.29
"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please follow https://h5.dingtalk.com/circle/healthCheckin.html?corpId=dingdc75e6471f48e6171a5c74e782e240c4&c003e554-f=3edf7be3-a&cbdbhh=qwertyuiop and download"
	einfo "${DISTFILE_BIN}"
	einfo "and place it in your DISTDIR directory."
}

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker
	rm opt/apps/com.alibabainc.dingtalk/files/0.9.0-Release.131/libm.so.6
	mkdir -p usr/share/applications
	cp opt/apps/com.alibabainc.dingtalk/entries/applications/com.alibabainc.dingtalk.desktop usr/share/applications/
}

pkg_postinst() {
	xdg_desktop_database_update
}
