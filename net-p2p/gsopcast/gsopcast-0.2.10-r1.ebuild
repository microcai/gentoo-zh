# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="gtk front-end of the p2p iptv"
HOMEPAGE="http://lianwei3.googlepages.com/home2"
SRC_URI="http://lianwei3.googlepages.com/${P}.tar.bz2
		http://download.sopcast.org/download/sp-sc.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-libs/gtk+"
RDEPEND="${DEPEND}
	amd64? ( app-emulation/emul-linux-x86-compat )"

RESTRICT="mirror"

src_unpack() {
	mkdir ${WORKDIR}
	cd ${WORKDIR}
	unpack ${P}.tar.bz2
	unpack sp-sc.tgz
}

src_compile() {
	cd ${S}
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd ${WORKDIR}/sp-sc
	dobin sp-sc-auth
	dosym sp-sc-auth /usr/bin/sp-sc
	cd ${S}/src
	dobin gsopcast
	insinto /usr/share/applications
	doins ${FILESDIR}/gsopcast.desktop
}

