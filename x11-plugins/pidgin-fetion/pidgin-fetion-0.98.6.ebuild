# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools

MY_P=${P/pidgin-//}
DESCRIPTION="Fetion protocol plugin for libpurple"
HOMEPAGE="http://blog.donews.com/gradetwo/category/137031.aspx"
SRC_URI="http://gentoo-china-overlay.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-libs/glib
	>=net-im/pidgin-2.3.1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	einfo "This is not an official gentoo package, please report your"
	einfo "bugs to http://www.donews.net/gradetwo"
	einfo
	elog "Select the 'fetion' protocol to use this plugin"
	elog "Server IP 221.130.44.193"
	elog "Read the following link if you get certification"
	elog "error while using this plugin:"
	elog "http://www.linuxsir.org/bbs/post2006922-693.html"
	einfo
}
