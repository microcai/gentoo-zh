# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils gnome2

DESCRIPTION="Gimmie is an experimental panel replacement for the Gnome desktop"
HOMEPAGE="http://beatnik.infogami.com/Gimmie"
SRC_URI="http://www.beatniksoftware.com/gimmie/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.3.1
	>=gnome-base/libgnomeui-2.5.2
	>=gnome-base/gnome-panel-2
	>=gnome-base/gconf-2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	virtual/pkgconfig"

RESTRICT="primaryuri"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README TODO"

src_unpack() {
	gnome2_src_unpack
}
