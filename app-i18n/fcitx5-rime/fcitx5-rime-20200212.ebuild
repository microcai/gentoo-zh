# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils gnome2-utils git-r3

DESCRIPTION="Rime Support for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-rime"

EGIT_REPO_URI="https://github.com/fcitx/fcitx5-rime.git"

if [[ ! "${PV}" =~ (^|\.)9999$ ]]; then
	EGIT_COMMIT="72a9df7910c2b41201e57d70e72f8843bf881505"
fi

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-i18n/fcitx5
	>=app-i18n/librime-1.0
	>=app-i18n/rime-data-0.3.0
	x11-libs/libnotify
	!app-i18n/fcitx-rime"

DEPEND="${RDEPEND}"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
