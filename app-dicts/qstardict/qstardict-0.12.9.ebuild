# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="QStarDict is a StarDict clone written with using Qt"
HOMEPAGE="http://qstardict.ylsoftware.com/"
SRC_URI="http://qstardict.ylsoftware.com/files/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ia64"
IUSE="dbus nls"
RDEPEND=">=x11-libs/qt-4.2 >=dev-libs/glib-2.0"
DEPEND="${RDEPEND}"
PROVIDE="virtual/stardict"

pkg_setup() {
	if (use dbus && ! built_with_use "x11-libs/qt" dbus); then
		eerror "You need to build x11-libs/qt with the 'dbus' USE flag"
		die "qstardict needs x11-libs/qt with the 'dbus' USE to work with D-Bus"
	fi
}

src_compile() {
	QMAKE_FLAGS=""
	if ! use dbus; then
		QMAKE_FLAGS+="NO_DBUS=1 "
	fi
	if ! use nls; then
		QMAKE_FLAGS+="NO_TRANSLATIONS=1 "
	fi
	qmake $QMAKE_FLAGS || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install filed"
}

