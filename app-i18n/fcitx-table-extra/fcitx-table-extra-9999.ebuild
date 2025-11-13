# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=fcitx5-table-extra

inherit cmake git-r3 xdg

DESCRIPTION="Provides extra table for Fcitx, including Boshiamy, Zhengma, Cangjie, and Quick"
HOMEPAGE="https://github.com/fcitx/fcitx5-table-extra"
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-table-extra.git"

LICENSE="GPL-3+"
SLOT="5"
KEYWORDS=""

DEPEND="
	!app-i18n/fcitx-table-extra:4
	app-i18n/fcitx:5
	app-i18n/libime
"
RDEPEND="${DEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"
