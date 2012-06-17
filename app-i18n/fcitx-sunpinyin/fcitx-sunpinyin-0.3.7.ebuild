# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

DESCRIPTION="Fcitx Wrapper for sunpinyin."
HOMEPAGE="http://code.google.com/p/fcitx"
SRC_URI="http://fcitx.googlecode.com/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.4
	>=app-i18n/sunpinyin-2.0.4"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"
