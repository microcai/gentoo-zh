# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils qt4

DESCRIPTION="Linux Fetion a KDE IM client, Using CHINA MOBILE's Fetion Protocol"
HOMEPAGE="http://www.libfetion.cn/"


SRC_URI="http://www.libfetion.cn/download/App/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="mirror"


DEPEND="|| ( ( x11-libs/qt-gui
	x11-libs/qt-qt3support )
	>=x11-libs/qt-4.3 )
	virtual/libstdc++
	>=sys-devel/automake-1.5
	"

RDEPEND="${DEPEND}
	net-misc/curl
	"




src_compile()
{
	eqmake4 ${PN}.pro || die "qmake fail"
	emake || die "emake fail"
}

src_install()
{
	insinto /usr/share/libfetion
	doins fetion_utf8_CN.qm image
	doins -r image

	insinto /usr/share/applications
	doins LibFetion.desktop

	insinto /usr/share/pixmaps
	doins fetion.png

	insinto /usr/share/app-install/icons
	doins fetion.png

	dobin ${PN}
}
