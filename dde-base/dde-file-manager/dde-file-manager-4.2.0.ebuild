# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="Deepin File Manager and Desktop module for DDE"
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
IUSE="samba"

RDEPEND="sys-apps/file
		 x11-libs/gsettings-qt
		 x11-libs/gtk+:2
		 dev-qt/qtsvg:5
		 dev-qt/qtx11extras:5
		 dev-qt/qtconcurrent:5
		 dev-qt/qtmultimedia:5
		 dev-qt/qtdeclarative:5
		 sys-auth/polkit-qt[qt5]
		 app-text/poppler
		 dev-libs/libqtxdg
		 app-crypt/libsecret
		 x11-libs/libxcb
		 x11-proto/xproto
		 x11-libs/xcb-util
		 x11-libs/xcb-util-wm
		 dev-cpp/treefrog-framework
		 media-video/ffmpegthumbnailer
		 media-libs/taglib
		 media-video/mpv[libmpv]
		 dde-extra/deepin-shortcut-viewer
		 media-libs/gst-plugins-good
		 net-misc/socat
		 >=dde-base/dde-dock-4.2.0
		 dde-base/dde-qt-dbus-factory
		 dde-base/dde-qt5integration
		 dde-base/dde-daemon
		 dde-base/startdde
		 !dde-base/dde-desktop
		 samba? ( net-fs/samba )
	     "
DEPEND="${RDEPEND}
		 >=dde-base/deepin-tool-kit-0.2.4:=
		 >=dde-base/dtksettings-0.1.3
		 dde-extra/deepin-gettext-tools
	     "

src_prepare() {
#	sed -i "s|-0-2||g" dde-file-manager*/dde-file-manager*.pro
#	sed -i "s|-0-2||g" usb-device-formatter/usb-device-formatter.pro
#	sed -i "s|-0-2||g" dde-dock-plugins/disk-mount/disk-mount.pro
#	sed -i "s|-0-2||g" dde-desktop/dde-desktop-build.pri

	LIBDIR=$(get_libdir)
	sed -i "s|{PREFIX}/lib/|{PREFIX}/${LIBDIR}/|g" dde-dock-plugins/disk-mount/disk-mount.pro

	eqmake5	PREFIX=/usr VERSION=${PV} LIB_INSTALL_DIR=/usr/$(get_libdir)
	default_src_prepare
}

src_install() {
		emake INSTALL_ROOT=${D} install
		dobin ${FILESDIR}/dfmterm 
		dobin ${FILESDIR}/x-terminal-emulator
}

pkg_postinst() {
	einfo "${PN} needs x-terminal-emulator command to make OpenInTermial"
	einfo "function work. A command dfmterm is added to generate it. For"
	einfo "example, use 'dfmterm xterm' to set xterm as the terminal when"
	einfo "click 'Open In Terminal'"
}
