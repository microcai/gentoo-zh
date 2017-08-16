# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Deepin QML widgets and dbus factory"
HOMEPAGE="https://github.com/linuxdeepin/deepin-qml-widgets"
QML_FACTORY_VER="3.0.6"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/linuxdeepin/dbus-factory/archive/${QML_FACTORY_VER}.tar.gz -> qml-dbus-factory-${QML_FACTORY_VER}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dtk1"

RDEPEND="x11-libs/gtk+:2
		 dev-qt/qtdeclarative:5
		 dev-qt/qtwidgets:5
		 dev-qt/qtwebkit:5
		 dev-qt/qtx11extras:5
		 dev-qt/qtgraphicaleffects:5
		 dev-qt/qtgui:5
		"
DEPEND="${RDEPEND}
        dtk1? ( >=dde-base/deepin-tool-kit-0.3.4:= )
        !dtk1? ( >=dde-base/dtkwidget-0.3.3:= )
		"

S=${WORKDIR}

src_prepare() {
    if use dtk1; then
        sed -i "s|dtkwidget|dtkwidget1|g" widgets/widgets.pro
    fi   

	export QT_SELECT=qt5
	cd ${S}/${P}
	eqmake5
}

src_compile() {
	cd ${S}/${P}
	emake

	cd ${S}/dbus-factory-${QML_FACTORY_VER}
	make build-qml
}

src_install() {
	cd ${S}/${P}
	emake INSTALL_ROOT=${D} install
	
	cd ${S}/dbus-factory-${QML_FACTORY_VER}
	emake DESTDIR=${D} QT5_LIBDIR=$(qt5_get_libdir)/qt5 install-qml
}
