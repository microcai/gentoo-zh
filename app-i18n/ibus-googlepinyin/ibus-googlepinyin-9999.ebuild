# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

HOMEPAGE="http://libgooglepinyin,googlecode.com/"

inherit googlecode mercurial

SRC_URI=""
#http://libgooglepinyin.googlecode.com/files/libgooglepinyin-${PV}.tar.bz2"

EHG_REPO_URI="https://code.google.com/p/libgooglepinyin/"

DESCRIPTION="A fork from google pinyin on android "

LICENSE="Apache"
SLOT="0"
KEYWORDS=""
IUSE=""

COMM_DEPEND=">=app-i18n/ibus-1.3.99[python]
"
#app-i18n/opencc"

RDEPEND="${COMM_DEPEND}
	dev-util/cmake"
DEPEND="${COMM_DEPEND}"

MY_P=libgooglepinyin-$PV
S=${WORKDIR}/${MY_P}


src_configure(){
	cmake -DCMAKE_INSTALL_PREFIX=/usr
}
