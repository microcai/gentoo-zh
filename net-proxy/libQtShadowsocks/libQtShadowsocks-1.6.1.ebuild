# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt5-build

DESCRIPTION="A lightweight and ultra-fast shadowsocks library written in C++/Qt"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/librehat/libQtShadowsocks/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"

IUSE=""

RDEPEND=">dev-libs/botan-1.10[threads]
	dev-qt/qtconcurrent
	dev-qt/qtcore:5
	dev-qt/qtnetwork"

S="${WORKDIR}/${P}"
