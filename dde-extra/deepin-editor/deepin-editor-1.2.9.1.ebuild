# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit cmake-utils

DESCRIPTION="Simple editor for Deepin"
HOMEPAGE="https://github.com/linuxdeepin/deepin-editor"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
		dev-qt/qtwidgets:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtx11extras:5
		dev-qt/qtdbus:5
		dev-qt/qtsvg:5
		kde-frameworks/syntax-highlighting
		kde-frameworks/kcodecs
		sys-auth/polkit-qt[qt5(+)]
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXtst
		x11-libs/xcb-util
		x11-libs/libxcb
		"

DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-2.0.6:=
		>=dde-base/dtkwm-2.0.6
		dev-qt/linguist-tools
		dev-qt/qtchooser
		virtual/pkgconfig
		"

