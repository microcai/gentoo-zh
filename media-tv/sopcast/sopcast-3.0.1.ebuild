# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="SopCast free P2P Internet TV binary"
HOMEPAGE="http://www.sopcast.com/"
SRC_URI="http://cnc1.sopcast.cn/download/sp-auth.tgz -> ${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# All dependencies might not be listed, since the binary blob's homepage only lists libstdc++
DEPEND=""
RDEPEND="
	amd64? ( app-emulation/emul-linux-x86-compat )
	x86? ( virtual/libstdc++ )"

S="${WORKDIR}"/sp-auth
RESTRICT="strip"

src_install() {
	exeinto /opt/${PN}
	doexe sp-sc-auth
	dodir /opt/bin
	dosym /opt/{${PN},bin}/sp-sc-auth
	# we need to make the above available  for older
	# stuff expecting to find it with the old name
	dosym sp-sc-auth /opt/bin/sp-sc
	dodoc Readme
}
