# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

DESCRIPTION="This is a standalone module for fcitx, it can use pinyin API on the
internet to input."
HOMEPAGE="https://github.com/csslayer/fcitx-cloudpinyin"
SRC_URI="http://fcitx.googlecode.com/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.5"
DEPEND="${RDEPEND}
	dev-util/intltool"