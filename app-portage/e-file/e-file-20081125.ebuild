# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="e-file is like apt-file for gentoo, but data is online"
HOMEPAGE="http://li2z.cn/category/e-file"
SRC_URI="http://linuxfire.com.cn/~lily/${P} -> ${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="www-client/w3m"

S=${WORKDIR}

src_prepare() {
	cp "${DISTDIR}"/${P} ${PN}
}

src_install() {
	dobin ${PN}
}

