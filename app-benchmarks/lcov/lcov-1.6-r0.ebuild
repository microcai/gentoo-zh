# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="a graphical front-end for GCC's coverage test tool gcov"
HOMEPAGE="http://ltp.sourceforge.net/"
SRC_URI="mirror://sourceforge/ltp/${P}.tar.gz"

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5"
RDEPEND=""

src_install() {
	emake PREFIX="${D}" install || die "emake install failed"
}

