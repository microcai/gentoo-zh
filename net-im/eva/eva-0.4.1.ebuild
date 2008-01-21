# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  Exp $

inherit kde eutils

DESCRIPTION="A kde implement of QQ"
HOMEPAGE="http://sourceforge.net/projects/evaq"
SRC_URI="mirror://sourceforge/evaq/${P}.tar.bz2"
RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc hppa sparc amd64 ia64 alpha"

S=${WORKDIR}/eva

need-kde 3
