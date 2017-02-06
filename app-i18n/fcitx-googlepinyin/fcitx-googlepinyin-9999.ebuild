# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-2

EGIT_REPO_URI="https://github.com/fcitx/fcitx-googlepinyin.git"

DESCRIPTION="Fcitx Wrapper for googlepinyin"
HOMEPAGE="https://code.google.com/p/fcitx"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.1.1
	>=app-i18n/libgooglepinyin-0.1.1"
DEPEND="${RDEPEND}
	dev-util/intltool"
