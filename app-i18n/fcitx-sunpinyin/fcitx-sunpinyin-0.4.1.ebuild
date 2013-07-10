# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils gnome2-utils

DESCRIPTION="Fcitx Wrapper for sunpinyin."
HOMEPAGE="https://github.com/fcitx/fcitx-sunpinyin"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.8
	>app-i18n/sunpinyin-2.0.3
	app-i18n/sunpinyin-data"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-util/intltool
	sys-devel/gettext"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
