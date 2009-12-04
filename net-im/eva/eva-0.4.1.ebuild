# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde

DESCRIPTION="A kde implement of QQ"
HOMEPAGE="http://sourceforge.net/projects/evaq"
SRC_URI="mirror://sourceforge/evaq/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/eva
RESTRICT="mirror"

need-kde 3
