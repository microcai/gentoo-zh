# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/net-analyzer/iftop-cvs/iftop-cvs-0.1.0.ebuild,v 1.1 2005/09/26 19:04:12 scsi Exp $

inherit cvs eutils

IUSE=""

DESCRIPTION="display bandwidth usage on an interface"
HOMEPAGE="http://www.ex-parrot.com/~pdw/iftop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ia64 ~ppc sparc x86"

DEPEND="sys-libs/ncurses
		virtual/libpcap
		!net-analyzer/iftop"

ECVS_AUTH="pserver"
ECVS_SERVER="sphinx.mythic-beasts.com:/home/pdw/vcvs/repos"
ECVS_USER="anonymous"
ECVS_PASS=""
ECVS_MODULE="iftop"

S="${WORKDIR}/${ECVS_MODULE}"

src_compile()
{
	cd $S
	./bootstrap
	
	econf 
	make
}
src_install() {
	dosbin iftop
	doman iftop.8

	insinto /etc
	doins "${FILESDIR}"/iftoprc

	dodoc COPYING ChangeLog README
}
