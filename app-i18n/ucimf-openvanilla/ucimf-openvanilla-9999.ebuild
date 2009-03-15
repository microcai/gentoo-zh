# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_REPO_URI="http://ucimf.googlecode.com/svn/ucimf-openvanilla"
inherit autotools subversion

DESCRIPTION="The OpenVanilla IMF module for UCIMF"
HOMEPAGE="http://ucimf.googlecode.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug minimal"

DEPEND="app-i18n/libucimf"
RDEPEND="${DEPEND}
	!minimal? ( app-i18n/openvanilla-modules )"

src_unpack() {
	subversion_src_unpack
	eautoreconf
}

src_compile() {
	econf $(use_enable debug)
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
