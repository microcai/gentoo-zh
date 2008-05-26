# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/drwright/drwright-0.17.ebuild,v 1.11 2005/05/16 12:26:00 allanonjl Exp $

inherit gnome2 flag-o-matic toolchain-funcs

DESCRIPTION="A GNOME2 Applet that forces you to take regular breaks to prevent RSI."
HOMEPAGE="http://ftp.gnome.org/pub/GNOME/sources/drwright"
#URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/${PV}/${P} .tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 sparc ~ppc"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0.4
	>=x11-libs/pango-1.2
	>=dev-libs/glib-2.0.3
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}
	# get rid of strict-aliasing warnings
#	sed -i -e 's/-Wall//' ${S}/src/Makefile.in ${S}/src/Makefile.am
#	epatch ${FILESDIR}/drwright-tray-miss-warning-off.patch
}

