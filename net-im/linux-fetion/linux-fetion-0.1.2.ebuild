# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils qt4

DESCRIPTION="Linux Fetion a KDE IM client, Using CHINA MOBILE's Fetion Protocol"
HOMEPAGE="http://www.libfetion.cn/"

MY_PN=${PN/-/_}
MY_P=${MY_PN}-v${PV}

SRC_URI="http://www.libfetion.cn/download/App/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
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


S=${WORKDIR}/${MY_PN}


src_unpack()
{
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/linux-fetion-desktop.patch"
	echo -e "\nTARGET=${PN}\n" >> ${MY_PN}.pro
}

src_compile()
{
	eqmake4 ${MY_PN}.pro || die "qmake fail"
	emake || die "emake fail"
}

src_install()
{
	insinto /usr/share/libfetion
	doins fetion_utf8_CN.qm image
	doins -r image

	insinto /usr/share/applications
	doins LinuxFetion.desktop

	insinto /usr/share/pixmaps
	doins fetion.png

	insinto /usr/share/app-install/icons
	doins fetion.png

	dobin ${PN}
}
