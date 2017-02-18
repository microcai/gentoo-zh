# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Control Center of Deepin Desktop Environment"
HOMEPAGE="https://github.com/linuxdeepin/dde-control-center"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
		 dev-qt/qtsvg:5
       dev-qt/qtsql:5
		 dev-qt/qtx11extras:5
		 dev-libs/libqtxdg
		 dde-base/dde-daemon
		 dde-base/dde-api
		 dde-base/dde-account-faces
		 dde-base/dde-dock
		 dde-base/startdde
		 dde-base/deepin-desktop-base
	     "
DEPEND="${RDEPEND}
		 dde-base/deepin-tool-kit:=
	     "

src_prepare() {
		eqmake5	PREFIX=/usr WITH_MODULE_GRUB=NO WITH_MODULE_REMOTE_ASSIST=NO WITH_MODULE_SYSINFO_UPDATE=NO
}

src_install() {
		emake INSTALL_ROOT=${D} install
}
