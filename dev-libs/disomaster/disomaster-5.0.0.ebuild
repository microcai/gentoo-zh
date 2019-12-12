# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils

DESCRIPTION="A libisoburn wrapper class for Qt."
HOMEPAGE="https://github.com/linuxdeepin/disomaster"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		virtual/pkgconfig
		>=dev-qt/qtcore-5.7:5
		>=dev-libs/libisoburn-1.2.6
		"

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|PREFIX/lib|PREFIX/${LIBDIR}|g" libdisomaster/libdisomaster.pro
	QT_SELECT=qt5 eqmake5   PREFIX=/usr
	default_src_prepare
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
