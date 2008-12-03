# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="e-file is like apt-file in debian,it's used to search package name via filename for gentoo"
HOMEPAGE="http://li2z.cn/category/e-file"
SRC_URI="http://linuxfire.com.cn/~lily/${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="mirror"
DEPEND=""
RDEPEND="net-misc/curl"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/${P} ${PN}
}

src_install() {
	dobin ${PN}
}

