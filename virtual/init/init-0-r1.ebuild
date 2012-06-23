# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/init/init-0.ebuild,v 1.16 2012/05/16 07:40:58 heroxbd Exp $

DESCRIPTION="Virtual for various init implementations"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="!prefix? (
	kernel_linux? ( || ( >=sys-apps/systemd-185 >=sys-apps/sysvinit-2.86-r6 sys-process/runit ) )
	kernel_FreeBSD? ( sys-freebsd/freebsd-sbin )
	)"
DEPEND=""
