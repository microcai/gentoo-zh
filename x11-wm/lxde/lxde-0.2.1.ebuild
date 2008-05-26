# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/x11-wm/lxde/lxde-0.2.1.ebuild,v 1.1 2006/11/11 08:12:47 palatis Exp $

DESCRIPTION="Meta package for the LXDE desktop"
HOMEPAGE="http://lxde.sf.net/"

LICENSE="as-is"

KEYWORDS="~amd64"
SLOT="2"

S=${WORKDIR}

RDEPEND="x11-apps/smproxy
		x11-wm/icewm
		x11-wm/lxsession
		x11-wm/lxpanel"
