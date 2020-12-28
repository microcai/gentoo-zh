# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

HOMEPAGE="http://libgooglepinyin.googlecode.com/"

CMAKE_IN_SOURCE_BUILD=1

inherit googlecode cmake-utils

SRC_URI="http://libgooglepinyin.googlecode.com/files/${P}.tar.bz2"

DESCRIPTION="wrapper libgooglepinyin for IBus"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMM_DEPEND="
>=app-i18n/libgooglepinyin-${PV}
>=app-i18n/ibus-1.4
dev-lang/python
"
#app-i18n/opencc"

DEPEND="${COMM_DEPEND}
	dev-util/cmake"
RDEPEND="${COMM_DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare(){
	epatch "${FILESDIR}/${PN}-pagesizepatch.patch"
	cmake-utils_src_prepare
}
