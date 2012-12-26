# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


DESCRIPTION="OXIM setup tool "
HOMEPAGE="http://opendesktop.org.tw/"
SRC_URI="ftp://140.111.128.66/odp/OXIM/Source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="mirror"
RDEPEND="=app-i18n/oxim-${PV}"

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog AUTHORS NEWS README
	rm -rf ${D}/usr/share/gettext
}
