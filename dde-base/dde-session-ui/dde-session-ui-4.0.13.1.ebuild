# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Deepin desktop environment - Session UI module"
HOMEPAGE="https://github.com/linuxdeepin/dde-session-ui"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gsettings-qt
		 x11-misc/lightdm[qt5]
		 x11-libs/gtk+:2
		 x11-apps/xrandr
		 dev-qt/qtsvg:5
		 dde-base/dde-daemon
		 >dde-base/deepin-desktop-schemas-2.91.2
		 dde-base/startdde
	     "
DEPEND="${RDEPEND}
        >=dde-base/dtkwidget-2.0.0:=
		>=dde-extra/deepin-gettext-tools-1.0.6
		dde-base/dde-qt-dbus-factory:=
	    "

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|lib/deepin-daemon|${LIBDIR}/deepin-daemon|g" dde-*/*.pro
	eqmake5	PREFIX=/usr
	default_src_prepare
}

src_install() {
		emake INSTALL_ROOT=${D} install
}
