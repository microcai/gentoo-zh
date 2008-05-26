# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/media-fonts/fireflysung/fireflysung-1.2.6-r1.ebuild,v 1.1 2005/02/13 12:58:14 scsi Exp $

inherit font-got

DESCRIPTION="Chinese TrueType Arphic Fonts with bimpfont by firefly"
HOMEPAGE="http://firefly.idv.tw/test/Forum.php?Board=1"
SRC_URI="http://www.study-area.org/apt/firefly-font/fireflysung-${PV}.tar.gz"

LICENSE="Arphic"
SLOT="0"
KEYWORDS="x86"
IUSE="X"

#S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="ttf"

