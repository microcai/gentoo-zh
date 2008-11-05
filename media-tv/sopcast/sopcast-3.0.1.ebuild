# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="SopCast free P2P Internet TV binary"
HOMEPAGE="http://www.sopcast.com/"
SRC_URI="http://cnc1.sopcast.cn/download/sp-auth.tgz -> ${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"
S="${WORKDIR}/"sp-auth

RDEPEND="x86? ( virtual/libstdc++ )
	amd64? ( app-emulation/emul-linux-x86-compat )"

src_install() {
	dobin sp-sc-auth
	# we need to make the above available  for older
	# stuff expecting to find it with the old name
	dosym sp-sc-auth /usr/bin/sp-sc
	dodoc Readme
}
