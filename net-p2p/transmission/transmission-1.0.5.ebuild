# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PV="1.05"

DESCRIPTION="Simple BitTorrent client"
HOMEPAGE="http://www.transmissionbt.com/"
SRC_URI="http://download.transmissionbt.com/transmission/files/${PN}-${MY_PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="gtk"

RDEPEND=">=dev-libs/glib-2.6
		 >=dev-libs/openssl-0.9.8
		 gtk? ( >=x11-libs/gtk+-2.6 )"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/pkgconfig-0.19
		gtk? ( >=dev-util/intltool-0.35 )"

S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
	econf $(use_with gtk) --with-wx-config=no || die "configure failed"
	emake || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS
}
