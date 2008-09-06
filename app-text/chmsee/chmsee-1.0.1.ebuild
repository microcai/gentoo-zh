# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic

DESCRIPTION="Utility for viewing Microsoft .chm files."
HOMEPAGE="http://chmsee.gro.clinux.org"
SRC_URI="http://gro.clinux.org/frs/download.php/2245/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE="xulrunner"
RDEPEND=">=gnome-base/libglade-2.0
	>=x11-libs/gtk+-2.8
	dev-libs/chmlib
	dev-libs/openssl
	xulrunner? ( || ( =net-libs/xulrunner-1.9* =net-libs/xulrunner-1.8* ) )
	!xulrunner? ( >=www-client/mozilla-firefox-1.5.0.7 )"

DEPEND="${RDEPEND}"

src_compile() {
	local myconf
	if has_version '=net-libs/xulrunner-1.9*'; then
		myconf="${myconf} --with-gecko=libxul"
	else
		if use xulrunner; then
			myconf="${myconf} --with-gecko=xulrunner"
		else
			myconf="${myconf} --with-gecko=firefox"
		fi
	fi

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README
}
