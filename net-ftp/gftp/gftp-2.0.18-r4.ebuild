# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/net-ftp/gftp/gftp-2.0.18-r4.ebuild,v 1.2 2006/07/13 02:41:55 scsi Exp $

inherit eutils

DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://www.gftp.org/${P}.tar.bz2"
HOMEPAGE="http://www.gftp.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="gtk ssl zh_TW"

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
	epatch ${FILESDIR}/${P}-ssh2-read.patch

	# fix_remote_charsets
	use zh_TW && epatch ${FILESDIR}/${P}-11-pcman.diff.gz
}

src_compile() {
	econf $(use_enable gtk gtkport) $(use_enable ssl) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc ChangeLog README* THANKS TODO docs/USERS-GUIDE
}
