# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils gnome2-utils

MY_PV=${PV/_alpha/alpha}

DESCRIPTION="Shadowsocks-Qt5 is a native and cross-platform shadowsocks GUI client with advanced features."
HOMEPAGE="https://github.com/shadowsocks/libQtShadowsocks"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/librehat/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"

IUSE=""

S="${WORKDIR}/${PN}-${MY_PV}"

DEPEND="dev-libs/botan:2
	dev-libs/libappindicator:2
	>=net-proxy/libQtShadowsocks-2.0.0
	!!<net-proxy/shadowsocks-qt5-3.0.0_alpha
	dev-qt/qtconcurrent
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork
	dev-qt/qtwidgets:5
	media-gfx/zbar
	media-gfx/qrencode
	>=sys-devel/gcc-4.9[cxx]"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
