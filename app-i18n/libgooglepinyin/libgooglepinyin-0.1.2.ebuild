# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

HOMEPAGE="http://libgooglepinyin.googlecode.com/"

inherit googlecode cmake-utils

SRC_URI="http://libgooglepinyin.googlecode.com/files/${P}.tar.bz2"

DESCRIPTION="A fork from google pinyin on android "

LICENSE="Apache"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMM_DEPEND="
"
#app-i18n/opencc"

DEPEND="${COMM_DEPEND}
	dev-util/cmake"
RDEPEND="${COMM_DEPEND}"

MY_P=libgooglepinyin-$PV
S=${WORKDIR}/${MY_P}
