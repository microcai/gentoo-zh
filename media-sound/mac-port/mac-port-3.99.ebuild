# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=${P/-port/}-u4-b5
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Monkey's Audio Codec port to *nix"
HOMEPAGE="http://sourceforge.net/projects/mac-port"
SRC_URI="http://ftp.nluug.nl/pub/os/Linux/distr/pardusrepo/sources/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="asm"

DEPEND="asm? ( dev-lang/yasm )"
RDEPEND=""

src_compile() {
	econf $(use_enable asm assembly) || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
