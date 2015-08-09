# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

MY_PV=${PV}-stable

DESCRIPTION="A fork of libqtelegram by Aseman Team"
HOMEPAGE="https://github.com/Aseman-Land/libqtelegram-aseman-edition"
SRC_URI="https://github.com/Aseman-Land/libqtelegram-aseman-edition/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# FIXME: the qtmultimedia fails with gstreamer
DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtsql:5
	dev-qt/qtmultimedia:5[qml,-gstreamer]
	dev-qt/qtquick1:5
	dev-qt/qtgraphicaleffects:5
	dev-qt/qtgui:5
	dev-qt/qtquickcontrols:5
	dev-libs/openssl
	dev-libs/libappindicator
"
RDEPEND="${DEPEND}"

src_unpack(){
	unpack ${A}
	mv ${WORKDIR}/libqtelegram-aseman-edition-${MY_PV} ${S}
}

src_prepare(){
	sed -i 's/\/$$LIB_PATH//g' ./libqtelegram-ae.pro
}

src_configure(){
	eqmake5 PREFIX="${EPREFIX}/usr"
}

src_install(){
	emake INSTALL_ROOT="${D}" install
}
