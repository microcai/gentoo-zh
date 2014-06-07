# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

RESTRICT="mirror"

EGIT_COMMIT=v${PV}

EGIT_REPO_URI="git://github.com/avplayer/avbot.git"

DESCRIPTION="avbot connects QQ/XMPP/IRC/POP3/SMTP"
HOMEPAGE="http://qqbot.avplayer.org"

SRC_URI=""

LICENSE="GPL3"

SLOT="0"
KEYWORDS="x86 amd64"
IUSE="python zmq lua"

inherit cmake-utils git-r3


DEPEND="
	>=dev-libs/boost-1.55[nls,threads,context,static-libs,python=]
	dev-libs/openssl
	net-libs/gloox
	sys-libs/zlib
	lua? ( >=dev-lang/luajit-2.0 )
"
RDEPEND="${DEPEND}"

src_configure(){
	local mycmakeargs=(
		-DINTERNALGLOOX=OFF
		$(cmake-utils_use_enable python PYTHON)
		$(cmake-utils_use_enable lua LUA)
		$(cmake-utils_use_enable zmq ZMQ)
	)
	cmake-utils_src_configure
}
