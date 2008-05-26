# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/x11-misc/xim-select/xim-select-0.0.1.ebuild,v 1.4 2004/06/25 16:11:15 palatis Exp $

DESCRIPTION="A small shell script that tells you how you should set your variable."
HOMEPAGE="http://staff.gentoo.org.tw/~palatis/xim-select/"
SRC_URI="http://staff.gentoo.org.tw/~palatis/xim-select/files/xim-select-0.0.1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_compile() {
	einfo "Nothing to do for compile, either."
	return
}

src_install() {
	dobin xim-select.sh

	dodoc ChangeLog
	dodoc COPYING
	dodoc INSTALL
	dodoc README
	dodoc TODO
}
