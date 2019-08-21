# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7


DESCRIPTION="A fast, proxy smart selector"
HOMEPAGE="https://github.com/microcai/smartproxy"

EGIT_REPO_URI="https://github.com/microcai/smartproxy"
EGIT_COMMIT="v${PV}"

inherit cmake-utils git-r3
#SRC_URI="https://github.com/microcai/smartproxy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="system-boost"

RESTRICT="mirror"

RDEPEND="dev-libs/openssl
	system-boost? ( >=dev-libs/boost-1.70 )
"

DEPEND="dev-libs/openssl
	system-boost? ( >=dev-libs/boost-1.70 )
"

src_configure(){
	local mycmakeargs=(
		-DUSE_SYSTEM_OPENSSL=ON
		$(cmake-utils_use_with system-boost SYSTEM_BOOST)
		$(cmake-utils_useno system-boost Boost_USE_STATIC_LIBS)
	)
	cmake-utils_src_configure
}
