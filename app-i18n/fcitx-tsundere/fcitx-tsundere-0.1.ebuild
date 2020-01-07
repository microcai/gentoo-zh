# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils
DESCRIPTION="Fcitx Tsundere Addon"
HOMEPAGE="https://github.com/felixonmars/fcitx-tsundere"
SRC_URI="https://github.com/felixonmars/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"
