# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Library to deal with pinyin."
HOMEPAGE="https://github.com/libpinyin/libpinyin"
SRC_URI="https://github.com/downloads/${PN}/${PN}/${PN}-lite-${PV}.tar.gz
		-> ${P}.tar
	https://github.com/downloads/${PN}/${PN}/model.text.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=">=sys-libs/db-4
	dev-libs/glib:2
"
RDEPEND="${DEPEND}"

src_prepare() {
	ln -s "${DISTDIR}/model.text.tar.gz" "${S}/data" || die "link file error"
	sed -i '/wget.*model\.text\.tar\.gz/ d' "${S}/data/Makefile.am"

	default_src_prepare
}
