# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils kde4-base

DESCRIPTION="KDE Config Module for Fcitx"
HOMEPAGE="https://github.com/fcitx/kcm-fcitx"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.8"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig
	sys-devel/gettext"
