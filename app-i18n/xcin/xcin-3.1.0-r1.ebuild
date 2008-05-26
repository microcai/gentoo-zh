# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-i18n/xcin/xcin-3.1.0-r1.ebuild,v 1.3 2006/06/12 11:01:08 scsi Exp $

inherit eutils

DESCRIPTION="Chinese X Input Method"
HOMEPAGE="http://opendesktop.org.tw/modules/news/article.php?storyid=15"
SRC_URI="ftp://140.111.128.66/odp/xcin_v3/source/${P}.tar.gz"

LICENSE="XCIN"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="nls"

DEPEND="virtual/x11
	nls? (sys-devel/gettext)
    >=x11-libs/gtk+-2
	=sys-libs/db-3*
	>=app-i18n/libtabe-0.2.6"

RESTRICT="nostrip"

src_unpack()
{
	unpack ${A}
	# gcc3.2 changed the way we deal with -I. So until the configure script
	# is updated we need this hack as a work around.
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-gentoo.patch
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-db3.patch
}
src_compile() {
	econf \
		--with-xcin-rcdir=/etc/xcin \
		--with-xcin-dir=/usr/lib/xcin \
		--enable-static=no \
		||  die "./configure failed"

	emake -j1 || die
}
src_install()
{
	#make DESTDIR=${D} install
	make prefix=${D}/usr program_prefix=${D} install || die
	exeinto /usr/lib/gtk-2.0/immodules/
	doexe  src/gtk-xcin/im-xcin.so
}
