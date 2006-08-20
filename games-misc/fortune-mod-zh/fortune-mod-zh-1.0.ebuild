# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Chinese fortune shell script"
HOMEPAGE="http://code.google.com/p/chinese-fortune"
SRC_URI="http://chinese-fortune.googlecode.com/svn/trunk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="games-misc/fortune-mod"

src_install() {
	dobin fortune-zh
	dosym fortune-zh /usr/bin/fortune-sc
	dosym fortune-zh /usr/bin/fortune-tc
}
