# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="an ARM embedded hardware simulator"
HOMEPAGE="http://www.skyeye.org/"
SRC_URI="http://skyeye.git.sourceforge.net/gitroot/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	media-libs/freetype
	=sys-devel/llvm-3.0*
	sys-libs/ncurses
	x11-libs/gtk+:2
	x11-libs/pango"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( ChangeLog README TODO )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-{iconv,arm,common,testsuite,utils,llvm}.patch
}

