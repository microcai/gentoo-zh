# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

ESVN_REPO_URI="http://ucimf.googlecode.com/svn/trunk/${PN}"
inherit eutils autotools subversion

DESCRIPTION="Unicode Console InputMethod Framework"
HOMEPAGE="http://ucimf.googlecode.com"
SRC_URI="${HOMEPAGE}/files/UserManual.pdf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug doc"

DEPEND="media-libs/freetype:2 media-libs/fontconfig"
RDEPEND="${DEPEND}
	dev-util/dialog"

pkg_setup() {
	# Make sure utmp group exists.
	enewgroup utmp 406
}

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README TODO
	use doc && dodoc "${DISTDIR}"/UserManual.pdf
}
