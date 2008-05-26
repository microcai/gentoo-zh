# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/gftp/gftp-2.0.18-r6.ebuild,v 1.3 2007/09/22 10:58:48 armin76 Exp $

inherit eutils

DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://www.gftp.org/${P}.tar.bz2"
HOMEPAGE="http://www.gftp.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="gtk ssl"

RDEPEND=">=dev-libs/glib-2
		 sys-devel/gettext
		 sys-libs/ncurses
		 sys-libs/readline
		 gtk? ( >=x11-libs/gtk+-2 )
		 ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.9"

src_unpack() {
	unpack ${A}
	cd ${S}

	# patch to allow fetching of ssh2 files
	# that are read-only, see bug #91269 and upstream link.
	epatch "${FILESDIR}/${P}-ssh2-read.patch"
	# patch to allow for wildcard SSL certificates
	epatch "${FILESDIR}/${P}-ssl-wildcardcert.patch"
	# patch to not crash on IPv6 enabled hosts or on IPv4 transfer with the "ignore PASV address" function
	epatch "${FILESDIR}/${P}-ipv6.patch"
	# Fix issues in bug #188252
	epatch "${FILESDIR}"/${P}-188252.patch
	# fix_remote_charsets
	use zh_TW && epatch ${FILESDIR}/${P}-11-pcman.diff.gz

}

src_compile() {
	econf $(use_enable gtk gtkport) $(use_enable ssl) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc ChangeLog* README* THANKS TODO docs/USERS-GUIDE
}
