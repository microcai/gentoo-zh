# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="set of fortunes based on the chinese Lunyu"
HOMEPAGE="http://code.google.com/p/chinese-fortune/"
SRC_URI="http://chinese-fortune.googlecode.com/svn/trunk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="zenity"

RDEPEND="games-misc/fortune-mod
		 zenity? ( >=gnome-extra/zenity-2.10.1 )"

src_install() {
	insinto /usr/share/fortune
	doins zh-lunyu zh-lunyu.dat || die
	dosym zh-lunyu /usr/share/fortune/zh-lunyu.u8

	if use zenity ; then
		exeinto /usr/bin
		doexe gfortune-zh-lunyu
	fi
}
