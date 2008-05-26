# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/net-wireless/kwlan/kwlan-0.6.0.ebuild,v 1.1 2007/02/15 05:55:26 scsi Exp $

inherit kde

DESCRIPTION="A network manager for kde."
HOMEPAGE="http://home.arcor.de/tom.michel/"
SRC_URI="http://home.arcor.de/tom.michel/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="arts"

DEPEND="app-admin/sudo net-wireless/wpa_supplicant"
RDEPEND="${DEPEND}"

need-kde 3.3

src_compile()
{
	econf $(use_with arts) || die "econf failed"
	emake || die "emake failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "install failed"
}
