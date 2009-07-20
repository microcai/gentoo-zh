# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 2007/07/20 Exp $

DESCRIPTION="Meta package for the LXDE desktop"
HOMEPAGE="http://lxde.sf.net/"

LICENSE="as-is"

KEYWORDS="~amd64 ~x86"
SLOT="2"
IUSE="eeemod music gpicview"

S=${WORKDIR}

RDEPEND="x11-apps/smproxy
	x11-wm/openbox
	lxde-base/lxappearance
	lxde-base/lxde-common
	eeemod? ( lxde-base/lxlauncher )
	music? ( lxde-base/lxmusic )
	lxde-base/lxde-settings-daemon
	lxde-base/lxpanel
	lxde-base/lxrandr
	lxde-base/lxsession
	lxde-base/lxtask
	lxde-base/lxnm
	lxde-base/lxinput
	lxde-base/lxshortcut
	lxde-base/gtknetcat
	lxde-base/lxmenu-data
	lxde-base/lxterminal
	gpicview? ( media-gfx/gpicview )
	x11-misc/pcmanfm"
DEPEND="${RDEPEND}"

pkg_postinst() {
    einfo
	einfo "Install and setup LXDE:"
	einfo "http://lxde.sourceforge.net/install.html"
	einfo
}

