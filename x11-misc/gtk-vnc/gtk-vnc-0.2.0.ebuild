# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A VNC viewer widget for GTK"
HOMEPAGE="http://gtk-vnc.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="python examples"

RDEPEND="
>=net-libs/gnutls-1.4.0
>=x11-libs/gtk+-2.0
python? ( >=dev-lang/python-2.4
>=dev-python/pygtk-2.0 )"

DEPEND="$RDEPEND
dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf \
	`use_with python` \
	`use_with examples` || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL README NEWS
}
