# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit fdo-mime eutils qmake-utils

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/linuxdeepin/deepin-screenshot.git"
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
IUSE="sharing"


RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtx11extras:5
	dev-qt/qtdbus:5
	dde-base/deepin-menu

	sharing? ( dde-extra/deepin-social-sharing )
	!media-gfx/deepin-screenshot:2
	!media-gfx/deepin-screenshot:3
	"
DEPEND="${RDEPEND}
	x11-libs/libxcb
	x11-libs/xcb-util
	x11-libs/libXtst
	x11-libs/libX11
	x11-libs/libXext
	dde-base/deepin-tool-kit"

src_prepare() {
	eqmake5 PREFIX=/usr
}

src_install() {
	emake INSTALL_ROOT=${D} install

}
