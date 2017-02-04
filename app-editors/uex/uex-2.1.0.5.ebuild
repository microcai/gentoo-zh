# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Ultra Editor for Linux"
HOMEPAGE="http://www.ultraedit.com/"
SRC_URI="http://www.ultraedit.com/files/uex/Other/${P}_i386.tar.gz"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="strip mirror"

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodir /opt/
	mv "${WORKDIR}/${PN}/" "${D}"/opt/

	make_wrapper ${PN} ./uex "/opt/${PN}/bin"
}

pkg_postinst() {
	ewarn "This is free trial verion of Ultra Editor Linux"
	ewarn "Only 30 days period"
	ewarn "if you like it, got to official Web for registration"
}
