# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Deepin Desktop Enviroment (meta package)"
HOMEPAGE="http://www.linuxdeepin.com"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dde-base/deepin-system-settings
		dde-base/dss-modules-meta
		dde-base/deepin-desktop-environment
		dde-base/deepin-notifications
		dde-base/deepin-system-tray
		dde-base/deepin-xsession-settings
		dde-base/deepin-session
		sys-auth/consolekit"
