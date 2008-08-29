# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/app-misc/pcmanfm/pcmanfm-0.3.2.2.ebuild,v 1.1 2007/03/20 02:25:17 scsi Exp $

inherit eutils

DESCRIPTION="PCMan File Manager, an extremly fast and lightweight file manager with tabbed browsing"
HOMEPAGE="http://pcmanfm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_beta1/-beta}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

RDEPEND="x11-themes/gnome-icon-theme
	x11-misc/shared-mime-info
	virtual/fam"
DEPEND="$RDEPEND
	>=x11-libs/gtk+-2.8
	>=sys-devel/automake-1.9
	>=sys-apps/hal-0.5
	sys-devel/autoconf
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${P/_beta1/-beta}"

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS COPYING 
}

pkg_postinst() {
	einfo "If you are using fam as file alternation monitoring daemon, you have to"
	einfo "have famd up and running before pcmanfm starts."
	einfo
	einfo "We suggest you add famd into the default runlevel by doing:"
	einfo "	# rc-update add famd default"
	einfo "and bring up your file alternation monitor daemon:"
	einfo "	# /etc/init.d/famd start"
	einfo
	einfo "If you use gamin, nothing is to be done. so... USE GAMIN!!!"
}
