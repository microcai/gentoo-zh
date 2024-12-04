# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Korean Hangul input method for Fcitx"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-hangul"

inherit git-r3
EGIT_REPO_URI="https://github.com/fcitx/fcitx5-hangul"

LICENSE="LGPL-2.1+"
SLOT="5"

BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"
DEPEND="
	>=app-i18n/fcitx-5.1.5:5
	>=app-i18n/libhangul-0.0.12
	virtual/libiconv
	virtual/libintl
"
RDEPEND="${DEPEND}"

DOCS=(AUTHORS)
