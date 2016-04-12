# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils gnome2-utils

DESCRIPTION="A cross-platform GUI shadowsocks client"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/librehat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"

IUSE=""

RDEPEND="dev-libs/libappindicator:2
	>=net-proxy/libQtShadowsocks-1.8.0
	media-gfx/zbar
	media-gfx/qrencode"
DEPEND="${RDEPEND}
	>dev-libs/botan-1.10[threads]
	dev-qt/qtconcurrent
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

src_compile() {
	eqmake5 INSTALL_PREFIX="${D}"/usr
}
