# Copyright 1999-2003 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License, v2 or later 
# $Header: /home/cvsroot/ebuildteam/kde-misc/desktoptext-config/desktoptext-config-0.3.ebuild,v 1.1 2007/02/15 05:55:26 scsi Exp $ 

inherit kde-base || die
need-kde 3.2

DESCRIPTION="This little module for the control center gathers in one place all available settings for the desktop icons texts: Font, colors and shadow"
SRC_URI="http://kde-apps.org/CONTENT/content-files/53118-${P}.tar.bz2"
HOMEPAGE="http://kde-apps.org/content/show.php?content=53118"
LICENSE="GPL"
KEYWORDS="x86"
IUSE=""
SLOT="0"
#S=${WORKDIR}/$PN
RESTRICT="mirror"

