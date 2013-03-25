# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils gnome2-utils

DESCRIPTION="Rime Support for Fcitx"
HOMEPAGE="https://github.com/fcitx/"
SRC_URI="https://fcitx.googlecode.com/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.7
	app-i18n/librime
	app-i18n/rime-data
	x11-libs/libnotify"
DEPEND="${RDEPEND}"

src_prepare(){
	EPATCH_SOURCE="${FILESDIR}" EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
