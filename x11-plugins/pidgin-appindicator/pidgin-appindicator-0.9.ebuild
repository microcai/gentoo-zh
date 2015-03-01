# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

HOMEPAGE="https://github.com/philipl/pidgin-indicator"

inherit autotools


DESCRIPTION="plugin for Pidgin to use SNI protocol to show systray icon in Unity or KDE Plasma-Next"

SRC_URI="https://github.com/philipl/pidgin-indicator/releases/download/0.9/pidgin-indicator-${PV}.tar.bz2"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="net-im/pidgin
		dev-libs/libappindicator:2
		x11-libs/gtk+:2"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/pidgin-indicator-${PV}"
