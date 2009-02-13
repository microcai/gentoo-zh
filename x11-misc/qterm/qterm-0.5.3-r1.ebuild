# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="2"
inherit cmake-utils eutils

DESCRIPTION="BBS client for X Window System written in Qt"
HOMEPAGE="http://qterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/qterm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-core:4[ssl]
	x11-libs/qt-gui:4
	dev-libs/openssl"
DEPEND="${RDEPEND}"

DOCS="README TODO"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-as-needed.patch
	epatch "${FILESDIR}"/${PN}-desktop.patch

	sed -i -e '/^Exec/s/qterm/QTerm/' src/qterm.desktop.in || die
	# fix the broken language files
	#lrelease src/po/qterm_ch*.ts || die
}

src_install() {
	cmake-utils_src_install
	mv "${D}"/usr/bin/{qterm,QTerm} || die
}

pkg_postinst() {
	einfo
	elog "Since 0.4.0-r1, /usr/bin/qterm has been renamed to /usr/bin/QTerm."
	elog "Please see bug #176533 for more information."
	einfo
}
