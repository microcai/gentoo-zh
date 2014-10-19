# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="nocache - minimize filesystem caching effects"
HOMEPAGE="https://github.com/Feh/nocache"
SRC_URI="https://github.com/Feh/nocache/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile(){
	emake PREFIX=/usr
}

src_install(){
	einstall PREFIX=/usr DESTDIR="${D}"
}
