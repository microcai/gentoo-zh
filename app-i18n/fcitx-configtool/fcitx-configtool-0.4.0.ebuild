# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

DESCRIPTION="GTK based config tool for Fcitx."
HOMEPAGE="https://fcitx.googlecode.com/"
SRC_URI="http://fcitx.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.0
	dev-libs/glib:2
	x11-libs/gtk+:2
	dev-libs/libunique:1"
DEPEND="${RDEPEND}
	dev-util/intltool"

