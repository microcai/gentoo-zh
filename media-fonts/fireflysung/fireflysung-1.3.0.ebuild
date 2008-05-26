# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/media-fonts/fireflysung/fireflysung-1.3.0.ebuild,v 1.3 2006/05/27 11:40:24 palatis Exp $

inherit font-got

DESCRIPTION="Chinese TrueType Arphic Fonts with bimpfont by firefly"
HOMEPAGE="http://firefly.idv.tw/test/Forum.php?Board=1"
SRC_URI="http://www.study-area.org/apt/firefly-font/fireflysung-${PV}.tar.gz"

LICENSE="Arphic"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="X"

#S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="ttf"

