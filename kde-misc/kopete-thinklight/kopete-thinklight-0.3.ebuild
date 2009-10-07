# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/kde-misc/kopete-desklist/kopete-desklist-0.2.1.ebuild,v 1.1 2006/04/18 12:51:32 scsi Exp $

inherit kde
need-kde 3.4

DESCRIPTION="This kopete plugin lets a thinkpad's light flash on every incoming message. "
HOMEPAGE="http://kde-apps.org/content/show.php/kopete-thinklight?content=47886"
SRC_URI="http://kde-apps.org/CONTENT/content-files/47886-${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc"

IUSE=""
SLOT="0"

RESTRICT="mirror $RESTRICT"

#S=$WORKDIR/
