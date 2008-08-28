# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/x11-wm/lxde/lxde-0.2.4.ebuild,v 1.2 2007/03/20 09:37:22 paar Exp $

DESCRIPTION="Meta package for the LXDE desktop"
HOMEPAGE="http://lxde.sf.net/"

LICENSE="as-is"

KEYWORDS="~amd64 ~x86"
SLOT="2"

S=${WORKDIR}

RDEPEND="x11-apps/smproxy
		x11-wm/icewm
		x11-misc/lxsession
		>=x11-misc/lxpanel-0.2.4"
pkg_postinst() {
    einfo
	einfo "Install and setup LXDE:"
	einfo "http://lxde.sourceforge.net/install.html"
	einfo
	einfo "If lxpanel can't be loaded without netstatus,"
	einfo "remove it from /usr/share/lxpanel/default"
	einfo
}

