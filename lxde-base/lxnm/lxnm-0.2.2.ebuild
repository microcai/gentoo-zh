# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: v 1.0 2009.07.20 calchan Exp $

DESCRIPTION="a desktop-independent network manager"
HOMEPAGE="http://lxde.sourceforge.net"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_compile() {
	econf --disable-dependency-tracking
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS
}
