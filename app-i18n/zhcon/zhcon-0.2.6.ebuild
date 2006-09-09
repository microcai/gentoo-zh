# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-i18n/zhcon/zhcon-0.2.5.ebuild,v 1.1 2006/06/22 02:38:19 scsi Exp $

inherit eutils

MY_P=${P/6/5}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A Fast CJK (Chinese/Japanese/Korean) Console Environment"
HOMEPAGE="http://zhcon.sourceforge.net/"
SRC_URI="mirror://sourceforge/zhcon/${MY_P}.tar.gz
		mirror://sourceforge/zhcon/zhcon-0.2.5-to-0.2.6.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	sys-devel/autoconf"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/zhcon-0.2.5-to-0.2.6.diff.gz
	epatch ${FILESDIR}/zhcon-0.2.5.make-fix.patch
	epatch ${FILESDIR}/${P}.sysconfdir.patch
	epatch ${FILESDIR}/${P}.configure.in.patch
	./bootstrap
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README NEWS TODO THANKS
	dodoc ABOUT-NLS README.BSD README.gpm README.utf8
}
