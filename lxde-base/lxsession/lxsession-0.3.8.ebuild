# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 2007/07/20 Exp $

DESCRIPTION="LXDE Session Manager"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2
	x11-libs/libSM
	!lxde-base/lxsession-lite"
RDEPEND=$DEPEND

src_install () {
	emake install \
		prefix=${D}/usr \
		libdir=${D}/usr/lib64 \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		xsessiondir=${D}/usr/share/xsessions \
		defaultsdir=${D}/etc || die
	dodoc AUTHORS COPYING ChangeLog README
}
