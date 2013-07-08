# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Deepin session for login screen"
HOMEPAGE="http://www.linuxdeepin.com"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${PV}-5.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="gnome-base/gnome-session
		gnome-base/gnome-settings-daemon"

src_install() {

	insinto "/etc/xdg"
	doins -r ${S}/autostart

}
