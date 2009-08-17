# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit qt4

DESCRIPTION="Linux 1g1g is a desktop application for 1g1g.com"
HOMEPAGE="http://linux1g1g.mrcongwang.com/"
SRC_URI="https://sites.google.com/site/${PN}/home/${P/.2/-2}-src.tar.bz2?attredirects=0 -> ${P}.tar.bz2"

S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# xbindkeys for bindkeys.sh
DEPEND="x11-libs/qt-core
	x11-libs/qt-gui
	>=x11-libs/qt-webkit-4.5.0"
RDEPEND="${DEPEND}
	www-plugins/adobe-flash
	x11-misc/xbindkeys"

src_configure(){
	eqmake4
}

src_install(){
	dobin linux1g1g bindkeys.sh
	dodoc README
}

pkg_postinst() {
	einfo "Linux1g1g is a desktop application for linux user to listen to"
	einfo "1g1g.com without opening a browser."
	einfo "It is based on Qt and Webkit and developed by two fans of 1g1g.com"
	einfo "Visit www.1g1g.com and you will like it."
}
