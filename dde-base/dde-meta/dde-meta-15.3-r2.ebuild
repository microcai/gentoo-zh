# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

DESCRIPTION="Deepin Desktop Enviroment (meta package)"
HOMEPAGE="http://www.linuxdeepin.com"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="manual terminal multimedia"

RDEPEND="=dde-base/dde-control-center-3.0*
		dde-base/startdde
		=dde-base/dde-file-manager-1*
		=dde-base/dde-desktop-3.0*
		dde-base/dde-launcher
		dde-base/dde-dock
		dde-base/deepin-desktop-base
		dde-base/dde-session-ui
		dde-base/deepin-notifications
		manual? ( =dde-extra/dde-help-${PV}* )
		terminal? ( dde-extra/deepin-terminal )
	    multimedia? ( dde-extra/dde-meta-multimedia )
		"

