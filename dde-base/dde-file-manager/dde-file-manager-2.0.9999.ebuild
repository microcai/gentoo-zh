# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Deepin File Manager"
HOMEPAGE="https://github.com/linuxdeepin/dde-file-manager"
if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/linuxdeepin/${PN}.git"
	EGIT_BRANCH="develop2.0"
else
	SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/gsettings-qt
		 x11-libs/gtk+:2
		 dev-qt/qtsvg:5
		 dev-qt/qtx11extras:5
		 dev-qt/qtconcurrent:5
		 sys-auth/polkit-qt[qt5]
		 >dde-base/deepin-menu-2.90.1
		 dde-base/dde-daemon
		 app-crypt/libsecret
		 media-video/ffmpegthumbnailer
		 net-misc/socat
		 dde-base/startdde
	     "
DEPEND="${RDEPEND}
		 >=dde-base/deepin-tool-kit-0.2.0:=
		 >=dde-base/dtksettings-0.1.3
	     "

src_prepare() {
		eqmake5	PREFIX=/usr
}

src_install() {
		emake INSTALL_ROOT=${D} install
		rm ${D}/usr/share/dbus-1/interfaces/org.freedesktop.FileManager1.xml
		dobin ${FILESDIR}/dfmterm 
		dobin ${FILESDIR}/x-terminal-emulator
}

pkg_postinst() {
	einfo "${PN} needs x-terminal-emulator command to make OpenInTermial"
	einfo "function work. A command dfmterm is added to generate it. For"
	einfo "example, use 'dfmterm xterm' to set xterm as the terminal when"
	einfo "click 'Open In Terminal'"
}
