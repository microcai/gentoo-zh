# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/net-wireless/kwirelessmonitor/kwirelessmonitor-0.5.91.ebuild,v 1.1 2005/04/24 08:47:51 scsi Exp $

inherit kde

DESCRIPTION="KWirelessMonitor is a small KDE application that docks into the system tray and monitors the wireless network interface."
HOMEPAGE="http://www-2.cs.cmu.edu/~pach/kwirelessmonitor/"
SRC_URI="http://www-2.cs.cmu.edu/~pach/kwirelessmonitor/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="${DEPEND}
	net-wireless/wireless-tools"

need-kde 3.2