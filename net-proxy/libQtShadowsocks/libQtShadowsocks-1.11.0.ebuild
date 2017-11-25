# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils

DESCRIPTION="A lightweight and ultra-fast shadowsocks library written in C++/Qt"
HOMEPAGE="https://github.com/shadowsocks/libQtShadowsocks"
SRC_URI="https://github.com/librehat/libQtShadowsocks/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="1"
RESTRICT="mirror"

LICENSE="GPL-3"

IUSE="static"

DEPEND="dev-libs/botan:2
	dev-qt/qtconcurrent
	dev-qt/qtcore:5
	dev-qt/qtnetwork
	dev-qt/qttest:5
	>=sys-devel/gcc-4.9[cxx]"

src_configure() {
	local mycmakeargs="
	-DLIB_INSTALL_DIR=/usr/$(get_libdir)
	-DUSE_BOTAN2=ON"
	! use static && mycmakeargs+=" -DBUILD_SHARED_LIBS=ON "
	cmake-utils_src_configure
}
