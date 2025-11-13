# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

MY_PN="fcitx5-sayura"
DESCRIPTION="Fcitx-Sayura is a Sinhala input method for Fcitx input method framework"
HOMEPAGE="https://github.com/fcitx/fcitx5-sayura"
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-sayura.git"

LICENSE="LGPL-2.1+ MIT"
SLOT="5"
KEYWORDS=""

DEPEND="
	>=app-i18n/fcitx-5.1.12:5
"
RDEPEND="${DEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
"
