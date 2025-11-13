# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

MY_PN="fcitx5-rime"
DESCRIPTION="Chinese RIME input methods for Fcitx"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-rime"
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-rime.git"

LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS=""

DEPEND="
	!app-i18n/fcitx-rime:4
	>=app-i18n/fcitx-5.1.13:5
	app-i18n/librime
	app-i18n/rime-data
	virtual/libintl
"
RDEPEND="${DEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules
	sys-devel/gettext
	virtual/pkgconfig
"
