# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_ORG_MODULE="proxy_applet"

inherit eutils gnome2

DESCRIPTION="GNOME applet for changing network proxy configuration from gnome panel"
HOMEPAGE="http://www.andreafabrizi.it/?proxyapplet"
SRC_URI="http://www.andreafabrizi.it/download.php?file=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-libs/glib-2.26:2
	>=gnome-base/gnome-control-center-2.26:2
	>=sys-apps/dbus-1.4.1
	>=x11-libs/gtk+-2:2"

DEPEND="${RDEPEND}
	virtual/pkgconfig"
