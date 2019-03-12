# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
EGIT_REPO_URI="https://github.com/fcitx/fcitx-fbterm.git"

inherit git-2 cmake-utils

DESCRIPTION="fcitx-fbterm, add fbterm support to fcitx"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE=""
DEPEND="app-i18n/fcitx
	sys-devel/gettext"
RDEPEND="${DEPEND}
	app-i18n/fbterm"

src_unpack() {
	git-2_src_unpack
}
