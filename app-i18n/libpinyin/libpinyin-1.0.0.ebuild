# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools eutils

DESCRIPTION="Library to deal with Pinyin."
HOMEPAGE="https://github.com/libpinyin/libpinyin"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	     http://downloads.sourceforge.net/${PN}/model7.text.tar.gz"

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
	ln -s "${DISTDIR}/model7.text.tar.gz" "${S}/data" || die "link file error"
	sed -i '/wget.*model7\.text\.tar\.gz/ d' "${S}/data/Makefile.am"
	epatch_user
	eautoreconf
}
