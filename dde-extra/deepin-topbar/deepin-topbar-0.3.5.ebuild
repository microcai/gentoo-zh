# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils gnome2-utils

DESCRIPTION="A Desktop Topbar with some tools"
HOMEPAGE="https://github.com/kirigayakazushin/deepin-topbar"

if [[ "${PV}" == *9999* ]] ; then
     inherit git-r3
     EGIT_REPO_URI="https://github.com/kirigayakazushin/${PN}.git"
else
     SRC_URI="https://github.com/kirigayakazushin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	 KEYWORDS="~amd64 ~x86"
fi
LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=">=dev-qt/qtcore-5.6:5
		dev-qt/qtdbus:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtconcurrent:5
		dev-qt/qtx11extras:5
		dev-qt/qtsvg:5
		dev-qt/qtmultimedia:5[widgets]
		x11-libs/libxcb
		x11-libs/libXext
		x11-libs/libXtst
		x11-libs/libX11
		x11-libs/xcb-util
		x11-libs/xcb-util-wm
		x11-libs/xcb-util-image
		x11-libs/gsettings-qt
		dde-base/dtkwidget:=
		dde-base/dde-qt-dbus-factory
		"
DEPEND="${RDEPEND}
		virtual/pkgconfig
		"

src_prepare() {
	QT_SELECT=qt5 eqmake5 PREFIX=/usr
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

pkg_preinst() { gnome2_schemas_savelist;}
pkg_postinst() { gnome2_schemas_update; }
pkg_postrm() { gnome2_schemas_update; }
