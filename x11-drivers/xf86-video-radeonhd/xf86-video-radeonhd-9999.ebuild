# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
#EGIT_BRANCH="CS"
#EGIT_BRANCH="atombios_support"
#EGIT_BRANCH="quick_and_dirty_2d"
inherit git x-modular

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xorg/driver/xf86-video-radeonhd"
DESCRIPTION="Experimental Radeon HD video driver. Not ready for everyday use."
HOMEPAGE="http://gitweb.freedesktop.org/?p=xorg/driver/xf86-video-radeonhd;a=summary"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-proto/xextproto"
RDEPEND="${DEPEND}
	>=x11-base/xorg-server-1.3.0"

src_compile() {
	x-modular_src_compile
	cd utils/conntest/
	emake
}

src_install() {
	x-modular_src_install
	exeinto /usr/bin
	doexe utils/conntest/rhd_conntest
	dodoc utils/conntest/README
}

pkg_postinst() {
	elog "Have a look at the README and use rhd_conntest to report info to:"
	elog "http://lists.opensuse.org/radeonhd"
}
