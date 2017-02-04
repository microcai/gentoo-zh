# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils autotools

DESCRIPTION="Unicode Console InputMethod Framework"
HOMEPAGE="http://ucimf.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}.tar.gz
	doc? ( ${HOMEPAGE}/files/UserManual.pdf )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc sunpinyin chewing openvanilla"

DEPEND="media-libs/freetype:2 media-libs/fontconfig"
RDEPEND="${DEPEND}
	dev-util/dialog"
PDEPEND="sunpinyin? ( app-i18n/ucimf-sunpinyin )
	chewing? ( app-i18n/ucimf-chewing )
	openvanilla? ( app-i18n/ucimf-openvanilla )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-unistd.patch
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README TODO
	use doc && dodoc "${DISTDIR}"/UserManual.pdf
}
