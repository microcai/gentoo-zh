# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

MY_P=Yabasic

DESCRIPTION="Yet Another BASIC"
HOMEPAGE="http://yabasic.basicprogramming.org/"
SRC_URI="http://yabasic.basicprogramming.org/files/${MY_P}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/bison
sys-devel/flex"

RDEPEND=""

S="${WORKDIR}/${MY_P}-${PV}"

src_install(){
	dodir "/usr/bin"
	install yabasic "${D}/usr/bin/yabasic"
}
