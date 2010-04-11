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

RDEPEND=">=dev-libs/atk-1.30
	sys-libs/glibc
	x11-libs/cairo
	sys-apps/dbus
	dev-libs/dbus-glib
	gnome-base/gconf
	dev-libs/glib
	>=x11-libs/gtk+-2.18
	x11-libs/pango
	x11-libs/pixman
	x11-libs/libwnck
	x11-libs/libX11"
DEPEND="${DEPEND}"
