# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils 

DESCRIPTION="Unicode Console InputMethod Framework"
HOMEPAGE="http://ucimf.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/ucimf/libucimf-2.2.1.tar.gz 
http://downloads.sourceforge.net/ucimf/ucimf-openvanilla-2.10.1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="openvanilla"
DEPEND=""
RDEPEND="openvanilla? ( app-i18n/openvanilla-module-generic )"

src_compile() {
	cd ${S}/libucimf-2.2.0
	econf || die "econf failed"
	emake || die "emake failed"

	if use openvanilla; then
		cd ${S}/ucimf-openvanilla-2.10.0
		econf --includedir=${S}/libucimf-2.2.0/include  || die "econf failed"
		emake || die "emake failed"
	fi

}

src_install() {
	cd ${S}/libucimf-2.2.0
	emake DESTDIR="${D}" install || die "emake install failed"

	if use openvanilla; then
		cd ${S}/ucimf-openvanilla-2.10.0                                                               
		emake DESTDIR="${D}" install || die "emake install failed"
	fi
}

