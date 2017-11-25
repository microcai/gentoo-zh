# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils gnome2-utils

DESCRIPTION="A cross-platform GUI shadowsocks client"
HOMEPAGE="https://github.com/shadowsocks/libQtShadowsocks"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/librehat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"

IUSE=""

DEPEND="dev-libs/botan:0[threads]
	dev-libs/libappindicator:2
	>=net-proxy/libQtShadowsocks-1.10.0
	dev-qt/qtconcurrent
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork
	dev-qt/qtwidgets:5
	media-gfx/zbar
	media-gfx/qrencode"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

src_compile() {
	eqmake5 INSTALL_PREFIX="${D}"/usr
}
