# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 2007/07/20 Exp $

DESCRIPTION="LXDE desktop menu cache"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND=">=x11-libs/gtk+-2"
RDEPEND="${DEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS COPYING ChangeLog README
}
