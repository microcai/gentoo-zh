# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="avbot connects QQ/XMPP/IRC"
HOMEPAGE="http://qqbot.avplayer.org"
SRC_URI="https://github.com/avplayer/avbot/tarball/v${PV} -> avbot-${PV}.tar.gz
		https://github.com/avplayer/avhttp/tarball/9f9d1b09141226b537cbe98c257017c8b4478c6e ->
		avbot-avhttp-${PV}.tar.gz"

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
}


src_configure(){
	local mycmakeargs=(
		-DINTERNALGLOOX=OFF
	)
	cmake-utils_src_configure
}
