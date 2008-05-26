# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/net-ftp/gftp/gftp-2.0.18-r2.ebuild,v 1.1 2005/10/30 15:33:29 scsi Exp $

inherit eutils

DESCRIPTION="Gnome based FTP Client"
SRC_URI="http://www.gftp.org/${P}.tar.bz2"
HOMEPAGE="http://www.gftp.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls gtk ssl zh_TW"

DEPEND="virtual/x11
	ssl? ( dev-libs/openssl )
	gtk? ( >=x11-libs/gtk+-2 )
	!gtk? ( sys-libs/readline
		sys-libs/ncurses
		=dev-libs/glib-1.2* )"

#RDEPEND="nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# fix_remote_charsets
	use zh_TW && epatch ${FILESDIR}/${P}-fix_remote_charsets.patch
}

src_compile() {

	local myconf

	# do not use enable-{gtk20,gtkport} they are not recognized
	# and will disable building the gtkport alltogether
	if ! use gtk; then
		einfo "gtk+ disabled"
		myconf="${myconf} --disable-gtkport --disable-gtk20"
	fi

	econf \
			$(use_enable nls) \
			$(use_enable ssl) \
			${myconf} \
			|| die

	emake || die

}

src_install() {
	make DESTDIR=${D} install || die

	dodoc COPYING ChangeLog README* THANKS \
		TODO docs/USERS-GUIDE

}
