# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/net-ftp/gftp/gftp-2.0.18-r1.ebuild,v 1.2 2005/10/03 03:32:35 scsi Exp $

inherit eutils

DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://www.gftp.org/${P}.tar.bz2"
HOMEPAGE="http://www.gftp.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="nls gtk gtk2 ssl zh_TW"

DEPEND="virtual/x11
	ssl? ( dev-libs/openssl )
	gtk? (
		gtk2? ( >=x11-libs/gtk+-2 )
		!gtk2? ( =x11-libs/gtk+-1.2* ) )
	!gtk? ( sys-libs/readline
		sys-libs/ncurses
		=dev-libs/glib-1.2* )"

#RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {

	unpack ${A}

	cd ${S}
	# fix building gtk1 backend (#80845)
	epatch ${FILESDIR}/${P}-fix_gtk1.patch
	# fix_remote_charsets
	use zh_TW && epatch ${FILESDIR}/${P}-fix_remote_charsets.patch
	
}

src_compile() {

	local myconf

	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"

	# do not use enable-{gtk20,gtkport} they are not recognized
	# and will disable building the gtkport alltogether
	if use gtk
	then
		einfo "gtk+ enabled"
		use gtk2 \
			&& einfo "gtk2 enabled" \
			|| myconf="${myconf} --disable-gtk20"
	else
		einfo "gtk+ and gtk2 disabled"
		myconf="${myconf} --disable-gtkport --disable-gtk20"
	fi

	use ssl \
		&& myconf="${myconf}" \
		|| myconf="${myconf} --disable-ssl"

	econf ${myconf} || die
	emake || die

}

src_install() {
	make DESTDIR=${D} install || die

	dodoc COPYING ChangeLog README* THANKS \
		TODO docs/USERS-GUIDE

}
