# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Plugins for Deepin Desktop Environment (meta package)"
HOMEPAGE="http://www.linuxdeepin.com"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dde-extra/dde-plugins-clock-${PV}
		=dde-extra/dde-plugins-weather-${PV}
		=dde-extra/dde-plugins-audio-helper-${PV}"
