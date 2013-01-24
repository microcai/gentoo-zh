# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils

DESCRIPTION="a pidgin plugin based on lwqq, a excellent safe useful library for
webqq protocol"
HOMEPAGE="https://github.com/xiehuc/pidgin-lwqq"
SRC_URI="https://github.com/xiehuc/${PN}/archive/0.1-b.tar.gz
			-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-0.1-b"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+libev"

RESTRICT="mirror"

COMMON_DEPEND=">=net-im/pidgin-2.10[gstreamer]
	>=net-misc/curl-7.22
	libev? ( dev-libs/libev )"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

RDEPEND="${COMMON_DEPEND}"

src_configure(){
	mycmakeargs=(
		-DUOA=Off
		$(cmake-utils_use_with libev LIBEV)
	)
	cmake-utils_src_configure
}
