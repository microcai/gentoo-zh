# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/x11-misc/xttmgr/xttmgr-0.9.6.ebuild,v 1.3 2004/11/04 10:49:19 benny Exp $

inherit eutils

XTTMGR="${PF}.tar.gz"
SLOT="0"
LICSENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="A ttc/ttf font management tool"
HOMEPAGE="http://firefly.idv.tw 
		http://www.gentoo.org.tw"
SRC_URI="http://www.gentoo.org.tw/~benny/distfiles/${XTTMGR}
		http://firefly.idv.tw/setfont-xft/fonttools/SRC/${XTTMGR}"
IUSE=""
MAKEOPTS="${MAKEOPTS} -j1"
S=${WORKDIR}/${P}
DEPEND="media-libs/freetype"
RDEPEND="media-libs/freetype"
src_unpack() {
	unpack ${XTTMGR}
	epatch ${FILESDIR}/xttmgr.c.patch
}

src_compile() {
	emake
}

src_install() {
	dobin xttmgr
	einfo "*****************************"
	einfo "For more information use"
	einfo "xttmgr --help"
	einfo "*****************************"
	dodoc README.Big5
}
