# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Library to deal with pinyin."
HOMEPAGE="https://github.com/libpinyin/libpinyin"
SRC_URI="https://github.com/downloads/libpinyin/libpinyin/libpinyin-0.6.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND=">=sys-libs/db-4"
RDEPEND="${DEPEND}"

