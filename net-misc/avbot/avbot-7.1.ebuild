# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

RESTRICT="mirror"

DESCRIPTION="avbot connects QQ/XMPP/IRC"
HOMEPAGE="http://qqbot.avplayer.org"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="amd64 x86 arm"
IUSE=""

inherit cmake-utils

# vcs-snapshot

DEPEND="
	>=dev-libs/boost-1.54[nls,threads]
	dev-libs/openssl
	net-libs/gloox
"
RDEPEND="${DEPEND}"

src_configure(){
	local mycmakeargs=(
		-DINTERNALGLOOX=OFF
	)
	cmake-utils_src_configure
}
