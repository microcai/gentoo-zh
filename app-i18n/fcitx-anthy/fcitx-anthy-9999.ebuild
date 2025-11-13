# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="fcitx5-anthy"

inherit cmake git-r3 xdg

DESCRIPTION="Japanese Anthy input methods for Fcitx5"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-anthy"
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-anthy.git"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	!app-i18n/fcitx-anthy:4
	app-i18n/anthy
	>=app-i18n/fcitx-5.1.13:5
"
DEPEND="${RDEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"

DOCS=( AUTHORS )
