# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/x11-misc/lxsession/lxsession-0.1.1.ebuild,v 1.2 2007/03/20 09:37:22 paar Exp $

DESCRIPTION="LXDE GUI interface to RandR extention"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2
	x11-libs/libXrandr"
RDEPEND="${DEPEND}
	x11-proto/randrproto
	dev-util/pkgconfig
	sys-devel/gettext"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed!"
	dodoc AUTHORS COPYING ChangeLog README
}
