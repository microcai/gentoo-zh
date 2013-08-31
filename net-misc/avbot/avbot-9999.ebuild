# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

RESTRICT="mirror"

EGIT_HAS_SUBMODULES=1

EGIT_REPO_URI="git://github.com/avplayer/avbot.git"

DESCRIPTION="avbot connects QQ/XMPP/IRC/POP3/SMTP"
HOMEPAGE="http://qqbot.avplayer.org"

SRC_URI=""

LICENSE="GPL3"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

inherit cmake-utils git-2


DEPEND="
	>=dev-libs/boost-1.54[nls,threads,static-libs]
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
