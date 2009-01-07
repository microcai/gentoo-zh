# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

MY_P=${P/pidgin-//}
DESCRIPTION="Fetion protocol plugin for libpurple"
HOMEPAGE="http://blog.donews.com/gradetwo/category/137031.aspx"
SRC_URI="http://gentoo-china-overlay.googlecode.com/svn/distfiles/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="net-im/pidgin"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog DOC/*  || die "dodoc failed"
}

pkg_postinst() {
	einfo "This is not a official gentoo package, please report your"
	einfo "bugs to http://www.donews.net/gradetwo"
	einfo
	elog "Select the 'fetion' protocol to use this plugin"
	elog "Server IP 221.130.44.193"
	einfo
}
