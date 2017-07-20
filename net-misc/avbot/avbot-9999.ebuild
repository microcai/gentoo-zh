# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

RESTRICT="mirror"

EGIT_REPO_URI="https://github.com/avplayer/avbot.git"

DESCRIPTION="avbot connects QQ/XMPP/IRC/POP3/SMTP"
HOMEPAGE="http://qqbot.avplayer.org"

SRC_URI=""

LICENSE="GPL3"

SLOT="0"
KEYWORDS=""
IUSE="python lua"

inherit cmake-utils git-r3


DEPEND="
	>=dev-libs/boost-1.57[nls,threads,context,static-libs,python=]
	dev-libs/openssl
	net-libs/gloox
	sys-libs/zlib
	dev-libs/protobuf
	>=dev-db/soci-3.2[sqlite,boost]
	lua? ( >=dev-lang/luajit-2.0 )
	dev-lang/spidermonkey
	dev-qt/qtcore:5
"
RDEPEND="${DEPEND}"

src_configure(){
	local mycmakeargs=(
		-DINTERNALGLOOX=OFF
		$(cmake-utils_use_enable python PYTHON)
		$(cmake-utils_use_enable lua LUA)
	)
	cmake-utils_src_configure
}
