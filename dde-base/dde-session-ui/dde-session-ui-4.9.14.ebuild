# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Deepin desktop environment - Session UI module"
HOMEPAGE="https://github.com/linuxdeepin/dde-session-ui"
if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="systemd elogind"
REQUIRED_USE="^^ ( systemd elogind )"

RDEPEND="
		 x11-libs/gsettings-qt
		 x11-misc/lightdm[qt5]
		 x11-libs/libXext
		 x11-libs/libXtst
		 x11-libs/libX11
		 x11-libs/libXcursor
		 x11-libs/libXfixes
		 x11-apps/xrandr
		 dev-qt/qtcore:5
		 dev-qt/qtgui:5
		 dev-qt/qtdbus:5
		 dev-qt/qtx11extras:5
		 dev-qt/qtwidgets:5
		 dev-qt/qtsvg:5
		 >=dde-base/dde-daemon-3.27.2.4[systemd?,elogind?]
		 >=dde-base/deepin-desktop-schemas-2.91.2
		 dde-base/startdde
		"
DEPEND="${RDEPEND}
		>=dde-base/dtkwidget-2.0.0:=
		>=dde-base/deepin-gettext-tools-1.0.6
		>=dde-base/dde-qt-dbus-factory-1.1.5:=
		virtual/pkgconfig
		"

src_prepare() {

	if use elogind; then
		sed -i "s|libsystemd|libelogind|g" dde-switchtogreeter/dde-switchtogreeter.pro
		sed -i "s|systemd/sd-login.h|elogind/systemd/sd-login.h|g" dde-switchtogreeter/switchtogreeter.c
	fi

	LIBDIR=$(get_libdir)
	sed -i "s|lib/deepin-daemon|${LIBDIR}/deepin-daemon|g" d*/*.pro
	sed -i "s|/lib/|/${LIBDIR}/|g" d*/*.service dde-osd/notification/files/*.service.in misc/applications/deepin-toggle-desktop.desktop.in
	QT_SELECT=qt5 eqmake5 PREFIX=/usr
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
