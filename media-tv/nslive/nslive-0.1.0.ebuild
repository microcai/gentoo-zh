# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="nslive free P2P Internet TV binary"
LICENSE="nslive-unknown-license"
HOMEPAGE="http://www.newseetv.com"
SRC_URI="http://www.newseetv.com/soft/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
}

src_compile() {
	elog "This is the binary package and not need compile."
}

src_install() {
	dobin nslive nsweb
}

