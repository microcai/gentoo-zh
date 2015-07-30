# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="a pidgin plugin based on lwqq, a excellent safe useful library for
webqq protocol"
HOMEPAGE="https://github.com/xiehuc/pidgin-lwqq"
SRC_URI="( https://github.com/xiehuc/pidgin-lwqq/archive/v${PV}.tar.gz -> ${P}.tar.gz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 i386"
IUSE=""

RESTRICT="mirror"

COMMON_DEPEND=">=net-im/pidgin-2.10[gstreamer]
	>=net-im/liblwqq-${PV}"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

RDEPEND="${COMMON_DEPEND}"

src_unpack(){
	unpack ${A}
}

src_configure(){
	mycmakeargs=(
		-DUOA=Off
	)
	cmake-utils_src_configure
}
