# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils

MY_P=${P/_/-}
DESCRIPTION="HTML Help viewer for Unix/Linux"
HOMEPAGE="http://code.google.com/p/chmsee/"
SRC_URI="http://chmsee.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.8:2
	dev-libs/libxml2
	>=gnome-base/libglade-2.4:2.0
	>=x11-libs/gtk+-2.8:2
	dev-libs/chmlib
	dev-libs/libgcrypt
	net-libs/xulrunner:1.9"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.37"

S=${WORKDIR}/${MY_P}

RESTRICT="mirror"
DOCS="NEWS* README* AUTHORS ChangeLog*"
