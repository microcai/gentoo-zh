# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

DESCRIPTION="Convert X cursors to PNG images"
HOMEPAGE="https://github.com/eworm-de/xcur2png"
#SRC_URI="https://github.com/eworm-de/xcur2png/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://github.com/eworm-de/xcur2png/releases/download/${PV}/${P}.tar.gz"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libpng
	      x11-libs/libXcursor"
