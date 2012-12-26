# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Library to deal with pinyin."
HOMEPAGE="https://github.com/libpinyin/${PN}"
SRC_URI="https://github.com/downloads/libpinyin/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror"

DEPEND=">=sys-libs/db-4
	>=dev-libs/glib-2.4.0
"
RDEPEND="${DEPEND}"
