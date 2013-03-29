# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

DESCRIPTION="Fcitx Wrapper for sogoupinyin."
HOMEPAGE="http://code.google.com/p/fcitx"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/f/fcitx-sogoupinyin/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.6"
DEPEND="${RDEPEND}
	dev-util/intltool"
S=${WORKDIR}
