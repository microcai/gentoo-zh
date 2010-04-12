# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils

DESCRIPTION="Unicode Console InputMethod Framework"
HOMEPAGE="http://ucimf.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.gz ${HOMEPAGE}/files/UserManual.pdf"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="media-libs/freetype:2"
RDEPEND="${DEPEND}
	dev-util/dialog"

pkg_setup() {
	# Make sure utmp group exists.
	enewgroup utmp 406
}

src_prepare() {
	cp "${DISTDIR}"/UserManual.pdf .
}

src_configure() {
	econf $(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog README TODO UserManual.pdf || die "dodoc failed"
}
