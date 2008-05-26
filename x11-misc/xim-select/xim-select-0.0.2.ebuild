# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/x11-misc/xim-select/xim-select-0.0.2.ebuild,v 1.1 2004/06/25 16:11:15 palatis Exp $

DESCRIPTION="XIM selector"
HOMEPAGE="http://staff.gentoo.org.tw/~palatis/xim-select/"
SRC_URI="http://staff.gentoo.org.tw/~palatis/xim-select/files/${PN}-${PV}.tar.bz2"

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
	insinto /usr/bin
	dobin xim-select.sh

	insinto /etc/xim-select/fallback
	doins etc/xim-select/fallback/*

	dodoc ChangeLog
	dodoc COPYING
	dodoc INSTALL
	dodoc README
	dodoc TODO
}

pkg_postinst() {
	ewarn
	ewarn "The argument format has changed a lot from 0.0.1 => 0.0.2."
	ewarn "If you are upgrading from 0.0.1, you MUST remake your .xsession, "
	ewarn ".xinitrc or .gnomerc, else it will just fail."
	ewarn
}
