# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/media-fonts/opendesktop-fonts/opendesktop-fonts-1.4.2.ebuild,v 1.1 2007/03/07 06:34:41 scsi Exp $

inherit font-got

DESCRIPTION="Chinese TrueType Arphic Fonts with bimpfont by firefly"
HOMEPAGE="http://www.opendesktop.org.tw"
SRC_URI="ftp://ftp.opendesktop.org.tw/odp/ODOFonts/OpenFonts/${P}.tar.gz"

LICENSE="Arphic"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="X"
DEPEND="!media-fonts/fireflysung"
#S=${WORKDIR}
FONT_S="${S}"
FONT_SUFFIX="ttf ttc"

