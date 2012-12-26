# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils git-2

DESCRIPTION="an ARM embedded hardware simulator"
HOMEPAGE="http://www.skyeye.org/"
EGIT_REPO_URI="git://skyeye.git.sourceforge.net/gitroot/skyeye/skyeye"
EGIT_BRANCH="dyncom_arm_ppc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
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
