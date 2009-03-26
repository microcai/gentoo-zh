# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils

DESCRIPTION="Unicode Console InputMethod Framework"
HOMEPAGE="http://ucimf.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.gz
	doc? ( ${HOMEPAGE}/files/UserManual.pdf )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

DEPEND="sys-libs/zlib
	media-libs/freetype:2"
RDEPEND="${DEPEND}"

pkg_setup() {
	# Make sure utmp group exists.
	enewgroup utmp 406
}

src_configure() {
	econf $(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
	use doc && dodoc UserManual.pdf || die "dodoc failed"
}
