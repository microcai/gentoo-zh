# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils gnome2-utils

DESCRIPTION="Fcitx Wrapper for googlepinyin."
HOMEPAGE="https://github.com/fcitx/fcitx-googlepinyin"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.0
	>=app-i18n/libgooglepinyin-0.1.2"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-util/intltool
	sys-devel/gettext
	virtual/libiconv"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
