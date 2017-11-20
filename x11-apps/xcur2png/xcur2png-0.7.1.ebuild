# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

DESCRIPTION="Convert X cursors to PNG images"
HOMEPAGE="http://cli-apps.org/content/show.php/xcur2png?content=86010"
#SRC_URI="http://cli-apps.org/CONTENT/content-files/86010-${P}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://github.com/zhtengw/deepin-overlay/files/823155/xcur2png-0.7.1.tar.gz"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libpng
	      x11-libs/libXcursor"
