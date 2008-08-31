# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/x11-wm/lxde/lxde-0.2.4.ebuild,v 1.2 2007/03/20 09:37:22 paar Exp $

DESCRIPTION="Meta package for the LXDE desktop"
HOMEPAGE="http://lxde.sf.net/"

LICENSE="as-is"

KEYWORDS="~amd64 ~x86"
SLOT="2"
IUSE="eeemod"

S=${WORKDIR}

RDEPEND="x11-apps/smproxy
	x11-wm/openbox
	lxde-base/lxappearance
	lxde-base/lxde-common
	eeemod? ( lxde-base/lxlauncher )
	lxde-base/lxpanel
	lxde-base/lxrandr
	lxde-base/lxsession-lite
	lxde-base/lxtask
	lxde-base/lxterminal
	media-gfx/gpicview
	app-misc/pcmanfm"
DEPEND="${RDEPEND}"

pkg_postinst() {
    einfo
	einfo "Install and setup LXDE:"
	einfo "http://lxde.sourceforge.net/install.html"
	einfo
}

