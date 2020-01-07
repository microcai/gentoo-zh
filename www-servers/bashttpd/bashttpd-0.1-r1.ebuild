# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit systemd googlecode

S=""

DESCRIPTION="Simple HTTP Daemon Written in BASH"
SRC_URI="${HOMEPAGE}/files/${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 arm mips alpha"
IUSE="systemd"

RDEPEND="${DEPEND}
	app-shells/bash
	sys-apps/coreutils
	systemd? ( sys-apps/systemd )
"

src_install(){
	dodir /usr/bin
	install ${DISTDIR}/${P} ${D}/usr/bin/bashttpd

	if use systemd ; then
		systemd_dounit ${FILESDIR}/http-alt.socket
		systemd_dounit ${FILESDIR}/http-alt@.service

		systemd_dounit ${FILESDIR}/http.socket
		systemd_dounit ${FILESDIR}/http@.service

	fi
}
