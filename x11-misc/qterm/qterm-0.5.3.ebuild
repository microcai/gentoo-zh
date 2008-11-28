# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qterm/qterm-0.5.2.ebuild,v 1.1 2008/05/14 17:33:36 matsuu Exp $

EAPI="1"
inherit cmake-utils eutils versionator toolchain-funcs

DESCRIPTION="QTerm is a BBS client in Linux."
HOMEPAGE="http://qterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/qterm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/qt:4
	dev-libs/openssl"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.7"

MAKEOPTS="-j1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/^Exec/s/qterm/QTerm/' src/qterm.desktop.in || die
	# fix the broken language files
	lrelease src/po/qterm_ch*.ts || die
}

src_install() {
	cmake-utils_src_install
	mv "${D}"/usr/bin/qterm "${D}"/usr/bin/QTerm || die
	dodoc README TODO
}

pkg_postinst() {
	elog
	elog "Since 0.4.0-r1, /usr/bin/qterm has been renamed to /usr/bin/QTerm."
	elog "Please see bug #176533 for more information."
	elog
}
