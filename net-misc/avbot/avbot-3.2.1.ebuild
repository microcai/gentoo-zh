# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

AVHTTP_SHA1="3260f5e7136da45cc28e10a96a713942c05ffa16"
AVPROXY_SHA1="1e6b02763e3c6395ec4ac6703776879f755bc8d3"

RESTRICT="mirror"

DESCRIPTION="avbot connects QQ/XMPP/IRC"
HOMEPAGE="http://qqbot.avplayer.org"
SRC_URI="https://github.com/avplayer/avbot/tarball/v${PV} -> avbot-${PV}.tar.gz
		https://github.com/avplayer/avhttp/tarball/${AVHTTP_SHA1} -> avbot-avhttp-${PV}.tar.gz
		https://github.com/avplayer/avproxy/tarball/${AVPROXY_SHA1} -> avbot-avproxy-${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

inherit cmake-utils vcs-snapshot

DEPEND="
	>=dev-libs/boost-1.48[nls,threads]
	dev-libs/openssl
	net-libs/gloox
"
RDEPEND="${DEPEND}"

src_unpack(){
	vcs-snapshot_src_unpack
	rm avbot-${PV}/libwebqq/avhttp -rf
	mv avbot-avhttp-${PV} avbot-${PV}/libwebqq/avhttp
	rm avbot-${PV}/avproxy -rf
	mv avbot-avproxy-${PV} avbot-${PV}/avproxy
}


src_configure(){
	local amycmakeargs=(
		-DINTERNALGLOOX=OFF
	)
	cmake-utils_src_configure
}
