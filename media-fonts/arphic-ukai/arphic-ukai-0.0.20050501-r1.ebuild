# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/media-fonts/arphic-ukai/arphic-ukai-0.0.20050501-r1.ebuild,v 1.3 2006/05/27 11:40:24 palatis Exp $

inherit font-got

DESCRIPTION="This ming font aims to provide full sized CJK unicode truetype fontset, supporting all CJK characters in Unicode plane 0 (BMP) and plane 2. "
HOMEPAGE="http://www.freedesktop.org/wiki/Software_2fCJKUnifonts?action=highlight&value=%2FCJKUnifonts"
SRC_URI="http://debian.linux.org.tw/pub/3Anoppix/people/arne/ukai/ttf-${PN}_${PVR/r/}.tar.gz"

LICENSE="Arphic"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="X"

S=${WORKDIR}/ttf-${PN}-${PV}
FONT_S="${S}"
FONT_SUFFIX="ttf"

