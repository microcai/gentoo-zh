# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils
MY_P=${P/-port/}-u4-b5
S=${WORKDIR}/${MY_P}
RESTRICT="mirror"

DESCRIPTION="A Monkey's Audio Codec port to *nix"
HOMEPAGE="http://supermmx.org/linux/mac/"
SRC_URI="http://supermmx.org/resources/linux/mac/${MY_P}.tar.gz"
#http://ftp.nluug.nl/pub/os/Linux/distr/pardusrepo/sources/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="asm"

DEPEND="asm? ( dev-lang/yasm )"
RDEPEND=""

src_prepare() {
	epatch ${FILESDIR}/${PNV}-gcc-4.4.patch
}

src_configure() {
	econf $(use_enable asm assembly)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
