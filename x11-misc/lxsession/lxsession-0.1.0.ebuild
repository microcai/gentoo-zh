# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/x11-misc/lxsession/lxsession-0.1.0.ebuild,v 1.1 2006/11/11 08:12:47 palatis Exp $

DESCRIPTION="LXDE Session Manager"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.bz2"

LICENSE="GPL-2"

KEYWORDS="~amd64"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2
		x11-libs/libSM"
RDEPEND=$DEPEND

src_install () {
	emake install \
		prefix=${D}/usr \
		libdir=${D}/usr/lib64 \
		datadir=${D}/usr/share \
		xsessiondir=${D}/usr/share/xsessions \
		defaultsdir=${D}/etc || die
	dodoc AUTHORS COPYING ChangeLog README
}
