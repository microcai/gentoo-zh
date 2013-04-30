# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

RESTRICT="mirror"

DESCRIPTION="avbot connects QQ/XMPP/IRC"
HOMEPAGE="http://qqbot.avplayer.org"

AVHTTP_SHA1="5284641397021bc16fc8a8d0a3593c6205d7d27e"
AVPROXY_SHA1="6cd1287db156f60846ed530d2062ccdff0bc692e"

#SRC_URI="https://github.com/avplayer/avbot/tarball/v${PV} -> avbot-${PV}.tar.gz
#		https://github.com/avplayer/avhttp/tarball/${AVHTTP_SHA1} -> avbot-avhttp-${PV}.tar.gz
#		https://github.com/avplayer/avproxy/tarball/${AVPROXY_SHA1} -> avbot-avproxy-${PV}.tar.gz"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="amd64 x86 arm"
IUSE=""

inherit cmake-utils

# vcs-snapshot

DEPEND="
	>=dev-libs/boost-1.48[nls,threads]
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
