# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="fcitx5-hangul"

inherit cmake git-r3 xdg

DESCRIPTION="Korean Hangul input method for Fcitx"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-hangul"
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-hangul.git"

LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS=""

DEPEND="
	!app-i18n/fcitx-hangul:4
	>=app-i18n/fcitx-5.1.13:5
	>=app-i18n/libhangul-0.0.12
	virtual/libiconv
"
RDEPEND="${DEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"

DOCS=( AUTHORS )
