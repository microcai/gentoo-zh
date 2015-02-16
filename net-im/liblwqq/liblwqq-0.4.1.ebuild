# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="A Cross Platform WebQQ Protocol"
HOMEPAGE="https://github.com/xiehuc/lwqq"
SRC_URI="( https://github.com/xiehuc/lwqq/archive/v${PV}.tar.gz -> ${P}.tar.gz )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""
RESTRICT="mirror"

DEPEND="
	>=dev-db/sqlite-3.8.6
	>=net-misc/curl-7.22
	dev-libs/libev
	sys-libs/zlib"
RDEPEND="${DEPEND}"

src_unpack(){
	unpack ${A}
	mv ${WORKDIR}/lwqq-${PV} ${S}
}

src_prepare(){
	epatch ${FILESDIR}/0001-Fix-username-or-passwd-error.patch
}

src_configure(){
	mycmakeargs=(
		-DUOA=Off
	)
	cmake-utils_src_configure
}
