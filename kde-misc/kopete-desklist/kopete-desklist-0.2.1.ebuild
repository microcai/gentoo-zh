# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/kde-misc/kopete-desklist/kopete-desklist-0.2.1.ebuild,v 1.1 2006/04/18 12:51:32 scsi Exp $

inherit kde
need-kde 3.4

DESCRIPTION="Kopete DeskList is a plugin for the Kopete KDE Instant Messenger. It displays your contact list right on the Desktop, with various effects. "
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=32089"
HOMEPAGE="http://conrausch.elise.no-ip.com/"
SRC_URI="http://conrausch.elise.no-ip.com/kopete/desklist/desklist-${PV}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ppc"

IUSE=""
SLOT="0"

RESTRICT="mirror $RESTRICT"

S=$WORKDIR/desklist
