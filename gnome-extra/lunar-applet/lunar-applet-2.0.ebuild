# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2

DESCRIPTION="The Chinese Lunar applet for gnome"
HOMEPAGE="http://dev.inlsd.org/projects/lunar-applet"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc eds"

SRC_URI="http://lunar-applet.googlecode.com/files/${PF}.tar.gz"

RDEPEND=">=gnome-base/gnome-panel-2.16
    eds? ( >=gnome-extra/evolution-data-server-1.6 )"

DEPEND="${RDEPEND}
    app-text/scrollkeeper
    >=app-i18n/liblunar-0.2.5
    >=dev-util/pkgconfig-0.9
    >=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
    G2CONF="$(use_enable eds) "
}
