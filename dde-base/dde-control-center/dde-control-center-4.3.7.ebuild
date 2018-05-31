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
IUSE="redshift"

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
		 >=dde-base/dde-daemon-3.2.1
		 dde-base/dde-api
		 dde-base/dde-account-faces
		 dde-base/dde-dock
		 dde-base/startdde
		 dev-util/desktop-file-utils
		 dev-libs/geoip
		 dde-base/deepin-desktop-base
		 dde-base/dde-qt5integration
		 redshift? ( x11-misc/redshift )
	     "
DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-2.0.1:=
		>=dde-base/dde-qt-dbus-factory-0.3.1:=
	    "

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|{PREFIX}/lib/|{PREFIX}/${LIBDIR}/|g" plugins/*/*.pro
	sed -i "s|usr/lib/|usr/${LIBDIR}/|g" dialogs/reboot-reminder-dialog/reboot-reminder-dialog.pro
	QT_SELECT=qt5 eqmake5	PREFIX=/usr DISABLE_SYS_UPDATE=YES
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}

pkg_postinst() {
	elog "GeoIP databases are no longer installed by dev-libs/geoip ebuild."
	elog "You must run 'geoipupdate.sh -f' first to download the databases,"
	elog "otherwise, dde-control-center will run abnormally."

	geoipupdate.sh -f
}
