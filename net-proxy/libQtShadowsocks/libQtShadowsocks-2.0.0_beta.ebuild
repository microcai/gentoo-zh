# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils

MY_PV=${PV/_beta/beta}

DESCRIPTION="A lightweight and ultra-fast shadowsocks library written in C++/Qt"
HOMEPAGE="https://github.com/shadowsocks/libQtShadowsocks"
SRC_URI="https://github.com/librehat/libQtShadowsocks/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS=""
SLOT="2"
RESTRICT="mirror"

LICENSE="GPL-3"

IUSE="static"

DEPEND="dev-libs/botan:2
	dev-qt/qtconcurrent
	dev-qt/qtcore:5
	dev-qt/qtnetwork
	dev-qt/qttest:5
	!!<net-proxy/libQtShadowsocks-2.0.0_beta
	>=sys-devel/gcc-4.9[cxx]"

S="${WORKDIR}/${PN}-${MY_PV}"

src_configure() {
	local mycmakeargs="
	-DLIB_INSTALL_DIR=/usr/$(get_libdir)
	-DUSE_BOTAN2=ON"
	! use static && mycmakeargs+=" -DBUILD_SHARED_LIBS=ON "
	cmake-utils_src_configure
}
