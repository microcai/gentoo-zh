# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

DESCRIPTION="Unicode Console InputMethod Framework"
HOMEPAGE="http://ucimf.sourceforge.net/"
SRC_URI=""
ESVN_REPO_URI="http://ucimf.googlecode.com/svn/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="openvanilla"
DEPEND=""
RDEPEND="openvanilla? ( app-i18n/openvanilla-module-generic )"

src_compile() {
	cd ${S}/libucimf
	autoreconf --install --symlink
	econf || die "econf failed"
	emake || die "emake failed"

	if use openvanilla; then
		cd ${S}/ucimf-openvanilla/
		autoreconf --install --symlink
		econf CPPFLAGS=-I${S}/libucimf/include  || die "econf failed"
		emake || die "emake failed"
	fi	

}

src_install() {
	cd ${S}/libucimf/
	emake DESTDIR="${D}" install || die "emake install failed"

	if use openvanilla; then
		cd ${S}/ucimf-openvanilla/
		emake DESTDIR="${D}" install || die "emake install failed"
	fi	
}
