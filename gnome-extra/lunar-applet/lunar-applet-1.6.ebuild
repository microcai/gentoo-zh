# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit gnome2

DESCRIPTION="The Chinese Lunar applet for gnome"
HOMEPAGE="http://dev.inlsd.org/projects/lunar-applet"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="doc eds"

SRC_URI="http://ftp.inlsd.org/${PN}/${P}.tar.gz"

RDEPEND=">=gnome-base/gnome-panel-2.16
	eds? ( >=gnome-extra/evolution-data-server-1.6 )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	>=app-text/gnome-doc-utils-0.3.2
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable eds) "
}
