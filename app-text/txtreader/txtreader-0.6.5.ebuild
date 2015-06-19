# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

HOMEPAGE="http://txtreader4linux.googlecode.com"

inherit qt4-r2

DESCRIPTION="Txt Reader for linux（小说阅读器 for linux）,and it supports
windows too."

SRC_URI="http://txtreader4linux.googlecode.com/files/${P}.tar.gz"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore
dev-qt/qtgui"
RDEPEND="${DEPEND}"


src_install(){
	dodir /usr/bin
	install ${PN} ${D}/usr/bin
}
