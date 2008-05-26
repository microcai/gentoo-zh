# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-i18n/zhcon/zhcon-0.2.5.ebuild,v 1.2 2006/06/22 04:00:02 scsi Exp $

inherit eutils

DESCRIPTION="A Fast CJK (Chinese/Japanese/Korean) Console Environment"
HOMEPAGE="http://zhcon.sourceforge.net/"
SRC_URI="mirror://sourceforge/zhcon/${P}.tar.gz
		mirror://sourceforge/zhcon/zhcon-0.2.5-to-0.2.6.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	sys-devel/autoconf"
RDEPEND="virtual/libc"

pkg_preinst()
{
	if grep -q /usr/include/linux/wait.h
	then
		einfo "please modify /usr/include/linux/wait.h by below "
		einfo "to avoid compile error:"
		einfo "	vi /usr/include/linux/wait.h"
		einfo "	:%s/bit, word/bit, (volatile long unsigned int *)word/"
		einfo "	:wq"
		die
	fi
}
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/zhcon-0.2.5-to-0.2.6.diff.gz
	epatch ${FILESDIR}/zhcon-0.2.5.make-fix.patch
}

src_compile() {
	#autoconf || die "autoconf failed"
	./configure --prefix=/usr || die
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
