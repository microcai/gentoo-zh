# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit gnome2

DESCRIPTION="Chinese Lunar Library Gtk+ widget"
HOMEPAGE="http://liblunar.googlecode.com"
SRC_URI="http://liblunar.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-libs/lunar-date-2.4.0
	x11-libs/gtk+:3
	"

DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="$(use_enable python) $(use_enable doc)"
}
