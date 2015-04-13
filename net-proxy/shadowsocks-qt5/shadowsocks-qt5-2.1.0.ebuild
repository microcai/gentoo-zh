# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt5-build gnome2-utils

DESCRIPTION="A cross-platform GUI shadowsocks client"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/librehat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

IUSE=""

RDEPEND=">dev-libs/botan-1.10
	net-proxy/libQtShadowsocks
	dev-qt/qtcore:5
	dev-qt/qtnetwork
	dev-qt/qtconcurrent
	dev-qt/qtdbus:5
	media-gfx/zbar
	media-gfx/qrencode
	dev-libs/libappindicator"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

post_postinst() {
	gnome2_icon_cache_update
}
