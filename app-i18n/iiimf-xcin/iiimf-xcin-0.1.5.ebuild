# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-i18n/iiimf-xcin/iiimf-xcin-0.1.5.ebuild,v 1.1 2004/04/25 13:02:05 palatis Exp $

inherit iiimf

IUSE="debug"
DESCRIPTION="An IIIMF Language Engine for Traditional Chinese."
HOMEPAGE="http://tciiimf.sourceforge.net/"
SRC_URI="http://people.redhat.com/llch/iiimf-xcin/iiimf-le-xcin-0.1.5.tar.bz2"

KEYWORDS="~x86"
RDEPEND="app-i18n/iiimsf"

S=${WORKDIR}/${PN}
# sorry but I only do one job at a time.
MAKEOPTS="-j1"

src_unpack() {
	cd ${WORKDIR}
	unpack `basename ${SRC_URI}`
	find . -name CVS | xargs rm -rf
}

src_compile() {
	cd ${S}

	local MYCONF=""
	[ `use debug` ] && MYCONF="${MYCONF} --enable-debug"

	econf ${MYCONF} || die
	emake || die
}

src_install() {
	cd ${S}
	emake install DESTDIR=${D} || die

	dodoc README
	dodoc ChangeLog
}
