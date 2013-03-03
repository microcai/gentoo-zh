# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt4-r2 versionator eutils

MY_P="${PN}-$(replace_version_separator 2 '-')"
DESCRIPTION="Linux 1g1g is a desktop application for 1g1g.com."
HOMEPAGE="http://linux1g1g.mrcongwang.com/"
SRC_URI="http://yedown.cz.cc/1g1g/${PN}/${MY_P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# xbindkeys for bindkeys.sh
DEPEND="dev-qt/qtcore
	dev-qt/qtgui
	>=dev-qt/qtwebkit-4.5.0"
RDEPEND="${DEPEND}
	www-plugins/adobe-flash
	x11-misc/xbindkeys"

S=${WORKDIR}/${PN}

src_configure(){
	eqmake4 || die "eqmake4 failed"
}

src_install(){
	dobin ${PN} bindkeys.sh
	dodoc README
	domenu "${FILESDIR}"/${PN}.desktop
	doicon "${FILESDIR}"/${PN}.png
}

pkg_postinst() {
	einfo "Linux1g1g is a desktop application for linux user to listen to"
	einfo "1g1g.com without opening a browser."
	einfo "It is based on Qt and Webkit and developed by two fans of 1g1g.com"
	einfo "Visit www.1g1g.com and you will like it."
}
