# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Yet Another BASIC"
HOMEPAGE="http://yabasic.basicprogramming.org/"
SRC_URI="http://www.yabasic.de/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMDEP="
sys-libs/ncurses
x11-libs/libX11
x11-libs/libSM
x11-libs/libICE
"

DEPEND="virtual/yacc
sys-devel/flex
$COMDEP"

RDEPEND="$COMDEP"


