# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit cmake-utils gnome2-utils git-r3

DESCRIPTION="Rime Support for Fcitx5"
HOMEPAGE="https://gitlab.com/fcitx/fcitx5-rime"

EGIT_REPO_URI="https://gitlab.com/fcitx/fcitx5-rime.git"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS=""
IUSE=""

RDEPEND="app-i18n/fcitx5
	>=app-i18n/librime-1.0
	>=app-i18n/rime-data-0.3.0
	x11-libs/libnotify"

DEPEND="${RDEPEND}"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
