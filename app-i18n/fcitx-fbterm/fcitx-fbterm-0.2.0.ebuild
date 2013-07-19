# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Add fbterm support to fcitx"
HOMEPAGE="https://github.com/fcitx/fcitx-fbterm"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.6
	app-i18n/fbterm"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"
