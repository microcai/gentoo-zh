# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

MY_PV=${PV}-stable

DESCRIPTION="Telegram API tools for QtQML and Qml"
HOMEPAGE="https://github.com/Aseman-Land/TelegramQML"
SRC_URI="https://github.com/Aseman-Land/TelegramQML/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirrors"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=net-misc/libqtelegram-ae-0.5.0
	dev-qt/qtxml:5
	dev-qt/qtimageformats:5
"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv ${WORKDIR}/TelegramQML-${MY_PV} ${S}
}

src_prepare() {
	sed -i 's/\/$$LIB_PATH//g' ./telegramqml.pro
}

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr" BUILD_MODE+=lib
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
