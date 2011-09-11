# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils

DESCRIPTION="Fcitx Wrapper for googlepinyin"
HOMEPAGE="https://code.google.com/p/fcitx"
SRC_URI="http://fcitx.googlecode.com/files/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.1.1
	dev-libs/libgooglepinyin"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext"

