# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="Rime Support for Fcitx"
HOMEPAGE="http://code.google.com/p/rimeime/"
EGIT_REPO_URI="https://github.com/fcitx/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-i18n/rime-data
	app-i18n/fcitx
	app-i18n/librime
	x11-libs/libnotify
	"
DEPEND="${RDEPEND}"
