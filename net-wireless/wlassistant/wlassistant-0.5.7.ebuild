# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/net-wireless/wlassistant/wlassistant-0.5.7.ebuild,v 1.2 2007/04/04 02:25:28 scsi Exp $

inherit kde

DESCRIPTION="A small application allowing you to scan for wireless networks and connect to them."
HOMEPAGE="http://sourceforge.net/projects/wlassistant"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
RDEPEND=">=net-wireless/wireless-tools-27-r1
	virtual/dhcpc
	dev-util/scons"
need-kde 3.3

src_compile()
{
	cd ${S}
	./configure prefix=/usr
	make
}
