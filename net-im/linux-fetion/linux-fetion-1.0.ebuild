# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit flag-o-matic qt4-r2

MY_P=${PN/-/_}_v${PV}

DESCRIPTION="A QT4 IM client using CHINA MOBILE's Fetion Protocol"
HOMEPAGE="http://www.libfetion.cn/"
SRC_URI="http://libfetion-gui.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND="dev-libs/openssl
	net-misc/curl[ssl]
	dev-qt/qtgui
	dev-qt/qtcore"
RDEPEND=${DEPEND}

RESTRICT="primaryuri"
S=${WORKDIR}/${MY_P}

src_prepare() {
	if use amd64 ; then
		sed -i \
			-e "/libfetion_32.a/c    LIBS +=  -lcurl ./lib/libfetion_64.a" \
			-e "/libfetion.a/c    LIBS +=  -lcurl ./lib/libfetion_64.a" \
			${PN}.pro || die "sed failed"
	fi
	sed -i \
		-e 's/;Network/&;/' misc/LibFetion.desktop || die "failed to fix desktop entry"
}

src_compile() {
	filter-ldflags -Wl,--as-needed
	eqmake4
	default
}

src_install() {
	insinto /usr/share/libfetion
	doins fetion_utf8_CN.qm || die
	doins -r skins sound faces_image || die

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
