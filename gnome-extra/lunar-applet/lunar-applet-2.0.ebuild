# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit gnome2

DESCRIPTION="The Chinese Lunar applet for gnome"
HOMEPAGE="http://lunar-applet.googlecode.com"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="eds"

SRC_URI="http://lunar-applet.googlecode.com/files/${PF}.tar.gz"

RDEPEND=">=gnome-base/gnome-panel-2.16
	eds? ( >=gnome-extra/evolution-data-server-1.6 )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=x11-libs/liblunar-0.2.5
	virtual/pkgconfig
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable eds) "
}
