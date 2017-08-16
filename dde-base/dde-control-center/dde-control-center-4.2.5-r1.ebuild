# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Control Center of Deepin Desktop Environment"
HOMEPAGE="https://github.com/linuxdeepin/dde-control-center"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+dtk1"

RDEPEND="dev-qt/qtsvg:5
         dev-qt/qtsql:5
		 dev-qt/qtx11extras:5
		 dev-qt/qtdeclarative:5
		 dev-qt/qtmultimedia:5
		 dev-qt/qtconcurrent:5
		 dev-qt/qtnetwork:5
		 dev-qt/qtgui:5
		 dev-qt/qtwidgets:5
		 dev-libs/libqtxdg
		 x11-libs/startup-notification
		 dde-base/dde-daemon
		 dde-base/dde-api
		 dde-base/dde-account-faces
		 dde-base/dde-dock
		 dde-base/startdde
		 dev-util/desktop-file-utils
		 dev-libs/geoip
		 dde-base/deepin-desktop-base
		 dde-base/dde-qt5integration
	     "
DEPEND="${RDEPEND}
		dtk1? ( >=dde-base/deepin-tool-kit-0.3.4:= )
		!dtk1? ( >=dde-base/dtkwidget-0.3.3:= )
		 >=dde-base/dde-qt-dbus-factory-0.0.7
	     "

src_prepare() {
    if use dtk1; then
        sed -i "s|dtkwidget|dtkwidget1|g" dialogs/reboot-reminder-dialog/reboot-reminder-dialog.pro
        sed -i "s|dtkwidget|dtkwidget1|g" frame/frame.pro
        sed -i "s|dtkwidget|dtkwidget1|g" plugins/notify/notify.pro
        sed -i "s|dtkwidget|dtkwidget1|g" plugins/weather/weather.pro
        sed -i "s|dtkwidget|dtkwidget1|g" widgets/widgets.pri
    fi  
	LIBDIR=$(get_libdir)
	sed -i "s|{PREFIX}/lib/|{PREFIX}/${LIBDIR}/|g" plugins/*/*.pro
	sed -i "s|usr/lib/|usr/${LIBDIR}/|g" dialogs/reboot-reminder-dialog/reboot-reminder-dialog.pro
	eqmake5	PREFIX=/usr DISABLE_SYS_UPDATE=YES
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

pkg_postinst() {
	elog "GeoIP databases are no longer installed by dev-libs/geoip ebuild."
	elog "You must run 'geoipupdate.sh -f' first to download the databases,"
	elog "otherwise, dde-control-center will run abnormally."
}
