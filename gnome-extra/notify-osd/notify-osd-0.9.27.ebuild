# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="0"

inherit gnome2 eutils

DESCRIPTION="Daemon that displays passive pop-up notifications"
HOMEPAGE="https://launchpad.net/notify-osd"
SRC_URI="mirror://ubuntu/pool/main/n/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-misc/notification-daemon
	sys-apps/dbus
	>=x11-libs/gtk+-2.14"
RDEPEND="${DEPEND}"
