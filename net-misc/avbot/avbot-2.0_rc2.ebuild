# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="avbot connects QQ/XMPP/IRC"
HOMEPAGE="http://qqbot.avplayer.org"
SRC_URI="https://github.com/avplayer/avbot/tarball/v2.0-rc2 -> avbot-2.0_rc2.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

inherit cmake-utils vcs-snapshot

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
