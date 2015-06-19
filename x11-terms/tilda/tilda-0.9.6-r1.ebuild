# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils autotools

DESCRIPTION="A drop down terminal, similar to the consoles found in first person shooters"
HOMEPAGE="http://tilda.sourceforge.net"
SRC_URI="mirror://sourceforge/tilda/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=">=x11-libs/vte-0.30.1
	>=dev-libs/glib-2.8.4
	>=x11-libs/gtk+-3.0
	dev-libs/confuse"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
#	epatch "${FILESDIR}/${P}-gdk_resources.patch"
	epatch "${FILESDIR}/${P}-resizehotkey.patch"
	epatch "${FILESDIR}/${P}-fix.patch"
	epatch "${FILESDIR}/${P}-fix-composite.patch"
	epatch "${FILESDIR}/${P}-fix-glib_h-error.h"

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
