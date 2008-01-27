# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/gxemul/gxemul-0.4.3.ebuild,v 1.2 2006/11/13 17:21:13 drizzt Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A Machine Emulator, Mainly emulates MIPS, but supports other CPU types."
HOMEPAGE="http://gavare.se/gxemul/"
SRC_URI="http://gavare.se/gxemul/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="X"

RDEPEND="X? ( || ( ( x11-libs/libX11
				x11-libs/libXaw
				x11-libs/libXdmcp
				)
			virtual/x11 ) )"

DEPEND="${RDEPEND}
		X? ( || ( x11-proto/xproto virtual/x11 ) )"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch ${FILESDIR}/gxemul-0.4.3-godson.patch
}

src_compile() {
	tc-export CC
	local myconf=""

	use X || myconf="${myconf} --disable-x"

	einfo "Configuring with: ${myconf}"
	./configure ${myconf} || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	dobin gxemul || die "gxemul not found in ${S}"
	doman man/gxemul.1
	dodoc HISTORY LICENSE README RELEASE TODO
	dohtml doc/*
}
