# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Library to deal with pinyin."
HOMEPAGE="https://github.com/libpinyin/libpinyin"
SRC_URI="http://downloads.sourceforge.net/${PN}/libpinyin/${PN}-lite-${PV}.tar.gz
		-> ${P}.tar
	http://downloads.sourceforge.net/${PN}/models/model5.text.tar.gz"

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
	ln -s "${DISTDIR}"/model.text.tar.gz data || die
	sed -e '/wget/d' -i data/Makefile.am || die
	epatch_user
	eautoreconf
}

