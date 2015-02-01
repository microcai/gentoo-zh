# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# This ebuild come from sunrise repository. Zugaina.org only host a copy.
# For more info go to http://gentoo.zugaina.org/
# ************************ General Portage Overlay ************************
# ==========================================================================

EAPI=5
inherit gnome2

DESCRIPTION="Gnome OSD notification system"
HOMEPAGE="http://www.gnomefiles.org/app.php?soft_id=350"
SRC_URI="http://telecom.inescporto.pt/~gjc/${PN}/0.12/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc dbus"

RDEPEND=">=dev-lang/python-2.3.0
	>=dev-python/pygtk-2.4.0
	>=dev-python/gnome-python-2.6.0
	dbus? ( dev-python/dbus-python )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_postinst() {
	gnome2_pkg_postinst

	# see the Installation section of the README
	kill -s HUP `pidof gconfd-2` > /dev/null 2>&1 || true
}
