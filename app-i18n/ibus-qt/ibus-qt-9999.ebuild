# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://github.com/phuang/ibus-qt.git"
inherit cmake-utils git

DESCRIPTION="Experimental Qt4 immodule for IBus framework"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI=""

LICENSE="LGPL-2.1" #FIXME
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-apps/dbus
	x11-libs/qt-core
	x11-libs/qt-dbus"
RDEPEND="${DEPEND}"
