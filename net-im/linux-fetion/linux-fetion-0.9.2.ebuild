# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit flag-o-matic qt4

DESCRIPTION="Linux Fetion, a QT4 IM client using CHINA MOBILE's Fetion Protocol"
HOMEPAGE="http://www.libfetion.cn/"
MY_P=${PN/-/_}_${PV}
S=${WORKDIR}/${MY_P}
SRC_URI="http://libfetion-gui.googlecode.com/files/${PN/-/_}_${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND="dev-libs/openssl
	net-misc/curl[ssl]
	x11-libs/qt-gui
	x11-libs/qt-qt3support"
RDEPEND=${DEPEND}

RESTRICT="primaryuri"

src_prepare() {
	if use amd64 ; then
		sed -i \
			-e "/libfetion_32.a/c    LIBS +=  -lcurl ./lib/libfetion_64.a" \
			-e "/libfetion.a/c    LIBS +=  -lcurl ./lib/libfetion_64.a" \
			${PN}.pro || die "sed failed"
	fi
}

src_compile() {
	filter-ldflags -Wl,--as-needed
	eqmake4
	default
}

src_install() {
	insinto /usr/share/libfetion
	doins fetion_utf8_CN.qm || die
	doins -r skins sound || die

	insinto /usr/share/pixmaps
	doins misc/fetion.png || die
	insinto /usr/share/applications
	doins misc/LibFetion.desktop || die

	if use doc ; then
		insinto /usr/share/doc/${PF}
		dohtml APIDocs/html/* || die "dohtml failed"
	fi

	dobin ${PN} || die "dobin failed"
}
