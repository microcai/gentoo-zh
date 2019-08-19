# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit cmake-utils

DESCRIPTION="A fast, proxy smart selector"
HOMEPAGE="https://github.com/microcai/smartproxy"

SRC_URI="https://github.com/microcai/smartproxy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"

RESTRICT="mirror"

RDEPEND="dev-libs/openssl
>=dev-libs/boost-1.70.0
"

DEPEND="dev-libs/openssl
>=dev-libs/boost-1.70.0
"

src_configure(){
	local mycmakeargs=(
		-DUSE_SYSTEM_OPENSSL=ON
		-DUSE_SYSTEM_BOOST=ON
		-DBoost_USE_STATIC_LIBS=OFF
	)
	cmake-utils_src_configure
}
