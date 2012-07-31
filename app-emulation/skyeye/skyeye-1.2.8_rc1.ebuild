# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils

DESCRIPTION="An ARM embedded hardware simulator"
HOMEPAGE="http://www.skyeye.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="sys-libs/ncurses
	media-libs/freetype
	x11-libs/gtk+:2
	dev-libs/glib:2
	x11-libs/pango"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix.patch"
}

src_install() {
	dobin skyeye || die "install skyeye"
	dodoc ChangeLog README
}
