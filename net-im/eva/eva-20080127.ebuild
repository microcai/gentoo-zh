# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde

DESCRIPTION="A kde implement of QQ"
HOMEPAGE="http://sourceforge.net/projects/evaq"
SRC_URI="http://www.myswear.net/myswear/eva/beta/${P}_1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S=${WORKDIR}/eva
RESTRICT="mirror"

need-kde 3
