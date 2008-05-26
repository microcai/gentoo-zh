# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-i18n/libtabe/libtabe-0.2.6.ebuild,v 1.1 2005/11/15 04:01:29 scsi Exp $

inherit rpm eutils

DESCRIPTION="Libtabe provides bimsphone support for xcin-2.5+"
HOMEPAGE="http://libtabe.sourceforge.net/"
SRC_URI="ftp://ftp.isu.edu.tw/pub/Linux/Fedora/linux/core/3/SRPMS/${P}-9.src.rpm"

LICENSE="XCIN"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="doc"

DEPEND="=sys-libs/db-3*"

S=${WORKDIR}/${PN}

src_unpack() {
	rpm_src_unpack
	cd ${S}
	epatch ${FILESDIR}/${PN}-db3.patch
}

src_compile() {
	econf \
		--with-db-inc=/usr/include/db3 \
		--with-db-lib=/usr/lib \
		--with-db-bin=/usr/bin \
		--enable-shared || die "econf failed"
	emake -j1 || die " make failed"
}

src_install() {
	einstall || die "install failed"
	use doc && dodoc doc/*
}
