# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Fcitx support for Qt5"
HOMEPAGE="https://github.com/fcitx/fcitx-qt5"
SRC_URI="http://github.com/fcitx/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

inherit cmake-utils

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtgui:5
	app-i18n/fcitx[dbus]"
RDEPEND="${DEPEND}"


