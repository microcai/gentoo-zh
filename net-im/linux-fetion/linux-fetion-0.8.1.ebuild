# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils qt4

DESCRIPTION="Linux Fetion a KDE IM client, Using CHINA MOBILE's Fetion Protocol"
HOMEPAGE="http://www.libfetion.cn/"


SRC_URI="http://www.libfetion.cn/download/App/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="primaryuri"


RDEPEND="|| ( ( x11-libs/qt-gui
	x11-libs/qt-qt3support )
	>=x11-libs/qt-4.3 )
	virtual/libstdc++
	net-misc/curl
	"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.5
	"




src_compile()
{
	if use amd64 ; then
		sed -i -e "/libfetion.a/c    LIBS +=  -lcurl ./libfetion_64.a" ${PN}.pro
		sed -i -e "/libfetion_32.a/c    LIBS +=  -lcurl ./libfetion_64.a" ${PN}.pro
	else
		sed -i -e "/libfetion_64.a/c    LIBS +=  -lcurl ./libfetion_32.a" ${PN}.pro
		sed -i -e "/libfetion.a/c    LIBS +=  -lcurl ./libfetion_32.a" ${PN}.pro
	fi
	eqmake4 ${PN}.pro || die "qmake fail"
	emake || die "emake fail"
}

src_install()
{
	insinto /usr/share/libfetion
	doins fetion_utf8_CN.qm image
	doins -r image

	insinto /usr/share/applications
	doins misc/LibFetion.desktop

	insinto /usr/share/pixmaps
	doins misc/fetion.png

	insinto /usr/share/app-install/icons
	doins misc/fetion.png

	dobin ${PN}
}
