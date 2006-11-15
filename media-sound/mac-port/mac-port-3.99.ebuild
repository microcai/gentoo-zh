# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${P/-port/}-u4-b5
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Monkey's Audio Codec port to *nix"
HOMEPAGE="http://sourceforge.net/projects/mac-port"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="asm"

DEPEND="asm? ( dev-lang/yasm )"
RDEPEND=""

src_compile() {
        local myconf=""
        if use asm
        then
                myconf="${myconf} --enable-assembly=yes"
        fi

        econf ${myconf} || die "configure failed"
        emake || die "emake failed"
}

src_install() {
        emake DESTDIR="${D}" install || die "install failed"
}
