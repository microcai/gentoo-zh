# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils subversion

DESCRIPTION="an ARM embedded hardware simulator"
HOMEPAGE="http://www.skyeye.org/"
ESVN_REPO_URI="https://skyeye.svn.sourceforge.net/svnroot/skyeye/skyeye-v1/trunk"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="sys-libs/ncurses
	media-libs/freetype
	x11-libs/gtk+:2
	dev-libs/glib:2
	x11-libs/pango"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	dobin skyeye || die "install skyeye"
	dodoc ChangeLog README
}
