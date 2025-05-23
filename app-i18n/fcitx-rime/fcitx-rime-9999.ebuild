# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake git-r3

DESCRIPTION="Rime Support for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-rime"

EGIT_REPO_URI="https://github.com/fcitx/fcitx5-rime.git"

LICENSE="LGPL-2.1+"
SLOT="5"

RDEPEND="
	>=app-i18n/fcitx-5.1.5:5
	>=app-i18n/librime-1.0
	>=app-i18n/rime-data-0.3.0
	app-i18n/rime-prelude
	x11-libs/libnotify"
DEPEND="${RDEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"
