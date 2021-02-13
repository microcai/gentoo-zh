# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit eutils 

DESCRIPTION="libipmsg - IP Messenger library for UNIX"
HOMEPAGE="http://libipmsg.sourceforge.jp"
SRC_URI="mirror://sourceforge.jp/libipmsg/30890/${P}.tar.gz"

SLOT="0"         
IUSE=""
LICENSE="GPL-2" 
KEYWORDS="x86 amd64" 
RESTRICT="mirror" 

src_compile()
{
	econf || die "=================econf failed============="
	emake || die "emake failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "emake install failed" #
}
