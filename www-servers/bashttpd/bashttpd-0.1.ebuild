# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit googlecode

S=""

DESCRIPTION="Simple HTTP Daemon Written in BASH"
SRC_URI="${HOMEPAGE}/files/${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 arm mips alpha"
IUSE=""

RDEPEND="${DEPEND}
	app-shells/bash
	sys-apps/coreutils
"

src_install(){
	dodir /usr/bin
	install ${DISTDIR}/${P} ${D}/usr/bin/bashttpd
}
