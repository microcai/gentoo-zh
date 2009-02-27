# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils 

DESCRIPTION="Unicode Console InputMethod Framework"
HOMEPAGE="http://ucimf.sourceforge.net/"
SRC_URI="http://ucimf.googlecode.com/files/libucimf-2.2.4.tar.gz
http://ucimf.googlecode.com/files/ucimf-openvanilla-2.10.3.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="openvanilla"
DEPEND=""
RDEPEND="openvanilla? ( app-i18n/openvanilla-module-generic )"

src_compile() {
	cd ${S}/libucimf-2.2.4
	econf || die "econf failed"
	emake || die "emake failed"

	if use openvanilla; then
		cd ${S}/ucimf-openvanilla-2.10.3
		econf CPPFLAGS=-I${S}/libucimf-2.2.4/include  || die "econf failed"
		emake || die "emake failed"
	fi

}

src_install() {
	cd ${S}/libucimf-2.2.4
	emake DESTDIR="${D}" install || die "emake install failed"

	if use openvanilla; then
		cd ${S}/ucimf-openvanilla-2.10.3
		emake DESTDIR="${D}" install || die "emake install failed"
	fi
}

