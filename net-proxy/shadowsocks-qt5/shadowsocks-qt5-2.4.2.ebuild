# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt5-build gnome2-utils

DESCRIPTION="A cross-platform GUI shadowsocks client"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/librehat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"

IUSE=""

RDEPEND="dev-libs/libappindicator:2
	>=net-proxy/libQtShadowsocks-1.6.1
	media-gfx/zbar
	media-gfx/qrencode"
DEPEND="${RDEPEND}
	>dev-libs/botan-1.10[threads]
	dev-qt/qtconcurrent
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork"

S="${WORKDIR}/${P}"

PATCHES=(
	# https://github.com/librehat/shadowsocks-qt5/issues/190
	"${FILESDIR}/remove-gnome-from-appindicator-de-list.patch"
)

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
