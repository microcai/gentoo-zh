# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/zhcon/zhcon-0.2.6.ebuild,v 1.3 2008/06/09 12:46:04 flameeyes Exp $

WANT_AUTOMAKE="1.9"

inherit eutils autotools

MY_P=${P/6/5}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A Fast CJK (Chinese/Japanese/Korean) Console Environment"
HOMEPAGE="http://zhcon.sourceforge.net/"
SRC_URI="mirror://sourceforge/zhcon/${MY_P}.tar.gz
		mirror://sourceforge/zhcon/zhcon-0.2.5-to-0.2.6.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${DISTDIR}"/zhcon-0.2.5-to-0.2.6.diff.gz
	epatch "${FILESDIR}"/zhcon-0.2.5.make-fix.patch
	epatch "${FILESDIR}"/${P}.sysconfdir.patch
	epatch "${FILESDIR}"/${P}.configure.in.patch
	epatch "${FILESDIR}"/${P}+gcc-4.3.patch
	epatch "${FILESDIR}"/${P}-lrmi.c.patch
	epatch "${FILESDIR}"/${P}-amd64.patch
	eautoreconf
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README NEWS TODO THANKS
	dodoc ABOUT-NLS README.BSD README.gpm README.utf8
}
