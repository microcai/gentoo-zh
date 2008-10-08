# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit qt4

DESCRIPTION="Linux Fetion, a Qt4 IM client using CHINA MOBILE's fetion protocol"
HOMEPAGE="http://www.libfetion.cn/"
SRC_URI="http://www.libfetion.cn/download/App/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# FIXME:
RDEPEND="net-misc/curl
	|| (
		( x11-libs/qt-gui x11-libs/qt-qt3support )
		>=x11-libs/qt-4.3
	)"
DEPEND="${RDEPEND}"

RESTRICT="primaryuri"

src_compile() {
	if use amd64 ; then
		sed -i -e "/libfetion.a/c    LIBS +=  -lcurl ./libfetion_64.a" ${PN}.pro
		sed -i -e "/libfetion_32.a/c    LIBS +=  -lcurl ./libfetion_64.a" ${PN}.pro
	fi
	# eqmake4 dies on itself.
	eqmake4
	emake || die "emake fail"
}

src_install() {
	insinto /usr/share/libfetion
	doins fetion_utf8_CN.qm
	doins -r image sound

	insinto /usr/share/pixmaps
	doins misc/fetion.png

	insinto /usr/share/applications
	doins misc/LibFetion.desktop

	dobin ${PN}
}
