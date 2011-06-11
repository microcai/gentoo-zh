# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xelatex-package

DESCRIPTION="xeCJK is a package written for XeLaTeX which allows users to typeset CJK scripts easily"
HOMEPAGE="http://bbs.ctex.org/viewthread.php?tid=40232&extra=page%3D1&page=1"
SRC_URI="http://gentoo-china-overlay.googlecode.com/svn/distfiles/${P}.tar.bz2"

LICENSE="LPPL-1.3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

S=${WORKDIR}
RESTRICT="primaryuri"

src_install() {
	docinto examples
	dodoc examples/*.tex
	# Workaround to make paludis happier so that
	# it won't complain about missing directory
	# any more. :-)
	dodir /usr/share/texmf/doc/xetex/latex/${PN}
	xelatex-package_src_install
}

pkg_postinst() {
	einfo "Running mktexlsr to rebuild ls-R database...."
	mktexlsr
}

pkg_postrm() {
	einfo "Running mktexlsr to rebuild ls-R database...."
	mktexlsr
}
