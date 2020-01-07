# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils gnome2-utils

DESCRIPTION="Provides some other tables for fcitx, fork from ibus-table-others, scim-tables."
HOMEPAGE="https://github.com/fcitx/fcitx-table-other"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.8[table]"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	sys-devel/gettext"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
