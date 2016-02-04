# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils

DESCRIPTION="A lightweight and ultra-fast shadowsocks library written in C++/Qt"
KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/librehat/libQtShadowsocks/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"

IUSE=""

RDEPEND=">dev-libs/botan-1.10[threads]
	dev-qt/qtconcurrent
	dev-qt/qtcore:5
	dev-qt/qtnetwork
	dev-qt/qttest:5"

src_compile() {
	eqmake5 INSTALL_PREFIX="${D}"/usr
}

src_install() {
	emake install DESTDIR="${D}"
}

pkg_preinst() {
	sed -i 's/^prefix.*/prefix\=\/usr/' "${D}"/usr/lib/pkgconfig/QtShadowsocks.pc
}
