# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  Exp $

inherit kde eutils

DESCRIPTION="A kde implement of QQ"
HOMEPAGE="http://sourceforge.net/projects/evaq"
SRC_URI="http://www.myswear.net/myswear/eva/beta/${P}_1.tar.bz2"
RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

S=${WORKDIR}/eva

need-kde 3
