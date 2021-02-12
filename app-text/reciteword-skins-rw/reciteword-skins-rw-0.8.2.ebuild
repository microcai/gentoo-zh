# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Reciteword's rw skin."
HOMEPAGE="http://reciteword.cosoft.org.cn/"
SRC_URI="http://reciteword.cosoft.org.cn/reciteword/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc ~x86"

RDEPEND=">=app-text/reciteword-0.8.2"

src_install() {
	dodir /usr/share/reciteword/skins
	cd ${WORKDIR}
	cp -R rw ${D}/usr/share/reciteword/skins
}
