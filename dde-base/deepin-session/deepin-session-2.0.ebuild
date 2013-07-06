# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit

SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/d/${PN}/${PN}_${PV}.tar.gz"

DESCRIPTION="Deepin Desktop Session"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=gnome-base/gnome-settings-daemon-3.8.99
		>=gnome-base/gnome-session-3.8"
DEPEND=""

src_install() {
	insinto "/usr/share/gnome-session/sessions"
	doins ${S}/debian/deepin.session

	insinto "/usr/share/xsessions"
	doins ${S}/debian/deepin.desktop

}

