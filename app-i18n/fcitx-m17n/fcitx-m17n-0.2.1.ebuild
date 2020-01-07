# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils

DESCRIPTION="m17n support for fcitx."
HOMEPAGE="https://github.com/fcitx/fcitx-m17n"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.8
	dev-libs/m17n-lib"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	sys-devel/gettext"
