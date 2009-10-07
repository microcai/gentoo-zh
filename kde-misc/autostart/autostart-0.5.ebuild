# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde

DESCRIPTION="Control Center module for editing your ~/.kde/Autostart entries"
HOMEPAGE="http://beta.smileaf.org/"
SRC_URI="http://beta.smileaf.org/files/autostart/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
RESTRICT="mirror"
IUSE=""
SLOT="0"
DEPEND="=sys-devel/automake-1.6*"

need-kde 3.4

src_install() {

	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README

}
