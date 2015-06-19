# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils git-2

DESCRIPTION="a pidgin plugin based on lwqq, a excellent safe useful library for
webqq protocol"
HOMEPAGE="https://github.com/xiehuc/pidgin-lwqq"
SRC_URI=""

EGIT_REPO_URI="git://github.com/xiehuc/pidgin-lwqq.git"
EGIT_HAS_SUBMODULES=1

LICENSE="GPL"
SLOT="0"
KEYWORDS=""
IUSE="+libuv"

COMMON_DEPEND=">=net-im/pidgin-2.10[gstreamer]
	>=net-misc/curl-7.22
	libuv? ( dev-libs/libuv )"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

RDEPEND="${COMMON_DEPEND}"

src_configure(){
	mycmakeargs=(
		-DUOA=Off
		$(cmake-utils_use_with libuv LIBUV)
	)
	cmake-utils_src_configure
}
