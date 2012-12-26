# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${P/td/t}
DESCRIPTION="Four traditional Chinese dictionaries for dict"
HOMEPAGE=""
SRC_URI="ftp://freebsd.csie.ntu.edu.tw/users/rafan/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 ppc sparc amd64 ppc64"

DEPEND=">=app-text/dictd-1.5.5"

S=${WORKDIR}/${MY_P}

src_install() {
	insinto /usr/lib/dict
	doins *.dict.dz *.index || die
}

pkg_postinst() {
	einfo "Because this package is in utf-8, you should edit /etc/conf.d/dictd"
	einfo "Add --locale=en_US.UTF-8 into your EARGS in that file"
	einfo "to enable utf-8 support"
}
