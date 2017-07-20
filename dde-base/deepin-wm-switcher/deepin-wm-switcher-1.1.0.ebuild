# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="Window manager switcher for Deepin"
HOMEPAGE="https://github.com/linuxdeepin/deepin-wm-switcher"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dde-base/dde-daemon
		x11-wm/deepin-wm
		x11-wm/deepin-metacity"

DEPEND="${RDEPEND}
	      dev-qt/qtx11extras:5"
