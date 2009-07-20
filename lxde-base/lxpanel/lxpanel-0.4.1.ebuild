# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/x11-misc/lxpanel/lxpanel-0.2.4.ebuild,v 1.2 2007/03/20 09:37:22 paar Exp $

DESCRIPTION="lxpanel is a light-weight X11 desktop panel"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2 
		app-text/docbook2X
		x11-libs/libXmu
		x11-libs/libXpm"
RDEPEND="${DEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed!"
#	emake install \
#		prefix=${D}/usr \
#		libdir=${D}/usr/lib \
#		mandir=${D}/usr/share/man \
#		datadir=${D}/usr/share || die
	dodoc AUTHORS COPYING ChangeLog README
}
