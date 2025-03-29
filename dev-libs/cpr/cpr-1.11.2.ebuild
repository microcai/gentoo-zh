# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ Requests: Curl for People, a spiritual port of Python Requests."
HOMEPAGE="https://github.com/libcpr/cpr"
SRC_URI="https://github.com/libcpr/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+ssl mbedtls"

DEPEND="net-misc/curl
		dev-cpp/gtest
		mbedtls? ( net-libs/mbedtls )"

src_configure() {
	local mycmakeargs=(
		-DCPR_USE_SYSTEM_CURL=ON
		-DCPR_USE_SYSTEM_GTEST=ON
		-DBUILD_SHARED_LIBS=ON
		-DCPR_ENABLE_SSL=$(usex ssl)
		-DCPR_FORCE_MBEDTLS_BACKEND=$(usex mbedtls)
	)
	cmake_src_configure
}
