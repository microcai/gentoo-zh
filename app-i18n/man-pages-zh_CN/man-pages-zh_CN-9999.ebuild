# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-zh_CN/man-pages-zh_CN-1.5.ebuild,v 1.4 2010/10/19 10:25:16 leio Exp $

EAPI="5"

DESCRIPTION="A somewhat comprehensive collection of Chinese Linux man pages"
HOMEPAGE="https://github.com/man-pages-zh/manpages-zh"

RESTRICT="mirror"
SRC_URL=""

EGIT_REPO_URI="https://github.com/man-pages-zh/manpages-zh"

LICENSE="FDL-1.2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="virtual/man
	>=sys-apps/man-pages-3.83
"

inherit autotools git-r3

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --disable-zhtw
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install

	rm "${D}"/usr/share/man/zh_CN/man8/userdel.8
	rm "${D}"/usr/share/man/zh_CN/man8/groupadd.8
	rm "${D}"/usr/share/man/zh_CN/man8/chpasswd.8
	rm "${D}"/usr/share/man/zh_CN/man8/useradd.8
	rm "${D}"/usr/share/man/zh_CN/man8/usermod.8
	rm "${D}"/usr/share/man/zh_CN/man8/groupdel.8
	rm "${D}"/usr/share/man/zh_CN/man8/groupmod.8
	rm "${D}"/usr/share/man/zh_CN/man1/groups.1
	rm "${D}"/usr/share/man/zh_CN/man1/newgrp.1
	rm "${D}"/usr/share/man/zh_CN/man1/su.1
	rm "${D}"/usr/share/man/zh_CN/man1/chsh.1
	rm "${D}"/usr/share/man/zh_CN/man1/chfn.1

	dodoc README* DOCS/*
}
