# Copyright 1999-2003 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License, v2 or later 
# $Header: /home/cvsroot/ebuildteam/kde-misc/knetworkconf/knetworkconf-0.6.1.ebuild,v 1.1 2005/04/24 08:47:51 scsi Exp $ 

inherit kde-base || die
need-kde 3.2

DESCRIPTION="KNetworkConf is a KDE Control Center Module to configure the Network settings in a simple and intuitive way"
SRC_URI="mirror://sourceforge/knetworkconf/${P}.tar.bz2"
HOMEPAGE="http://www.merlinux.org/knetworkconf http://kde-apps.org/content/show.php?content=10108"
LICENSE="GPL"
KEYWORDS="x86"
IUSE=""
SLOT="0"
#S=${WORKDIR}/$PN
RESTRICT="nomirror"

