# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 qmake-utils

DESCRIPTION="Additional style plugins for Qt"
HOMEPAGE="https://code.qt.io/cgit/qt/qtstyleplugins.git/"
LICENSE="LGPL-2"
SLOT="5"

EGIT_REPO_URI="https://code.qt.io/cgit/qt/qtstyleplugins.git"
EGIT_COMMIT="335dbece103e2cbf6c7cf819ab6672c2956b17b3"
SRC_URI=""
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="dev-qt/qtgui:5[dbus]
		 dev-qt/qtwidgets:5
         x11-libs/gtk+:2
         x11-libs/libX11"
DEPEND="${RDEPEND}"

src_configure() {
	QT_SELECT=qt5 eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	elog ""
	elog "To make Qt5 applications use the gtk2 style"
	elog "insert the following into ~/.profile:"
	elog "QT_QPA_PLATFORMTHEME=gtk2"
	elog "For environments using ~/.pam_environment (gnome wayland):"
	elog "QT_QPA_PLATFORMTHEME OVERRIDE=gtk2"
	elog ""
}
