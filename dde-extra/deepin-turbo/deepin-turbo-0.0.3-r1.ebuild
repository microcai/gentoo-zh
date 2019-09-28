# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Booster Daemon to Speed up DTK Applications"
HOMEPAGE="https://github.com/linuxdeepin/deepin-turbo"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd elogind"
REQUIRED_USE="^^ ( systemd elogind )"

RDEPEND="dev-qt/qtwidgets:5
		sys-apps/dbus
		systemd? ( sys-apps/systemd )
		elogind? ( sys-auth/elogind )
		"
DEPEND="${RDEPEND}
		virtual/pkgconfig
		"

src_prepare() {
	if use elogind; then
		sed -i "s|lsystemd|lelogind|g" src/launcherlib/CMakeLists.txt
		sed -i "s|systemd/sd-daemon.h|elogind/systemd/sd-daemon.h|g" src/launcherlib/daemon.cpp
	fi

	LIBDIR=$(get_libdir)
	sed -i "s|lib/|${LIBDIR}/|g" src/*/CMakeLists.txt
	cmake-utils_src_prepare
}

