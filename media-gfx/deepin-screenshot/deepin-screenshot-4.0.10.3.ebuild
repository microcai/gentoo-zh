# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit fdo-mime eutils qmake-utils

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/deepin-screenshot.git"
	EGIT_BRANCH="develop"
	SRC_URI=""
	#KEYWORDS=""
	KEYWORDS="~amd64 ~x86"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Snapshot tools for linux deepin."
HOMEPAGE="https://github.com/linuxdeepin/deepin-screenshot"

LICENSE="GPL-3+"
SLOT="4"
IUSE=""


RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtx11extras:5
	dev-qt/qtdbus:5
	dev-qt/qtsvg:5
	dev-qt/qtmultimedia:5
	dde-base/deepin-menu
	dde-base/dde-daemon
	dde-base/deepin-gettext-tools
	>=dde-extra/deepin-shortcut-viewer-1.3.1
	>=dde-base/deepin-notifications-2.3.9
	!media-gfx/deepin-screenshot:2
	!media-gfx/deepin-screenshot:3
	"
DEPEND="${RDEPEND}
	dev-libs/glib
	sys-libs/mtdev
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/libXtst
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/startup-notification
	virtual/libudev
	media-libs/fontconfig
	media-libs/freetype
	x11-proto/xextproto
	x11-proto/recordproto
	>=dde-base/dtkwm-2.0.0
	>=dde-base/dtkwidget-2.0.0:=
	"

src_prepare() {
	QT_SELECT=qt5 eqmake5 PREFIX=/usr
}

src_install() {
	emake INSTALL_ROOT=${D} install

}
