# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/x11-misc/lxpanel/lxpanel-0.2.1.ebuild,v 1.3 2007/03/20 09:37:22 paar Exp $

DESCRIPTION="lxpanel is a light-weight X11 desktop panel"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2"
RDEPEND=$DEPEND

src_install () {
	emake install \
		prefix=${D}/usr \
		libdir=${D}/usr/lib64 \
		datadir=${D}/usr/share || die
	dodoc AUTHORS COPYING ChangeLog README
}
