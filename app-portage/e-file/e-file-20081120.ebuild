# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${P/file-/file.}
DESCRIPTION="e-file is like apt-file for gentoo, but data is online"
HOMEPAGE="http://li2z.cn/2008/11/20/e-file"
SRC_URI="http://linuxfire.com.cn/~lily/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="www-client/w3m"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/${MY_P} ${PN}
}

src_install() {
	dobin ${PN}
}

