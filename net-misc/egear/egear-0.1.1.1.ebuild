# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit qt4-r2

DESCRIPTION="eGear, a download tool written in QT4"
HOMEPAGE="egear.googlecode.com"
SRC_URI="http://egear.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/openssl
	net-misc/curl
	|| (
		( dev-qt/qtcore dev-qt/qtgui dev-qt/qtdbus )
		( >=dev-qt/qt4.3 )
	)"
RDEPEND="${DEPEND}"

RESTRICT="primaryuri"

src_compile() {
	eqmake4
	emake || die "emake fail"
}

src_install() {
	insinto /usr/share/pixmaps
	doins res/egear.png

	insinto /usr/share/applications
	doins misc/egear.desktop
	
	insinto /usr/lib/egear/plugins
	doins plugins/file_scanner.py

	dobin ${PN}
}
