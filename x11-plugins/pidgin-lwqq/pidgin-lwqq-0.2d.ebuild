# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
EGIT_HAS_SUBMODULES=true
EGIT_REPO_URI="git://github.com/xiehuc/pidgin-lwqq.git"
EGIT_COMMIT="e98f733aaaf1dce297eb4f9b44a895fbd9cbd290"

inherit cmake-utils git-2

DESCRIPTION="a pidgin plugin based on lwqq, a excellent safe useful library for
webqq protocol"
HOMEPAGE="https://github.com/xiehuc/pidgin-lwqq"
SRC_URI=""

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="mirror"

COMMON_DEPEND=">=net-im/pidgin-2.10[gstreamer]
	>=net-misc/curl-7.22
	dev-libs/libev "

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

RDEPEND="${COMMON_DEPEND}"

src_configure(){
	mycmakeargs=(
		-DUOA=Off
	)
	cmake-utils_src_configure
}
