# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils mercurial

EHG_REPO_URI="https://fcitx-googlepinyin.fcitx.googlecode.com/hg/"

DESCRIPTION="Fcitx Wrapper for googlepinyin"
HOMEPAGE="https://code.google.com/p/fcitx"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.1.1
	dev-libs/libgooglepinyin"
DEPEND="${RDEPEND}
	dev-util/intltool"

