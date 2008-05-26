#Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/net-misc/pcmanx/pcmanx-0.3.5.ebuild,v 1.2 2007/03/27 08:40:41 scsi Exp $

inherit eutils

DESCRIPTION="PCMan is an easy-to-use telnet client mainly targets BBS users formerly writen by gtk2"
SRC_URI="http://pcmanx.csie.net/release/pcmanx-gtk2-${PV}.tar.gz"
HOMEPAGE="http://pcmanx.csie.net/"
RESTRICT="nomirror"

S="${WORKDIR}/pcmanx-gtk2-${PV}"

KEYWORDS="x86 ~ppc amd64"
SLOT="0"
LICENSE="GPL"
IUSE="mozilla firefox"

DEPEND="
	fireofx? ( www-client/mozilla-firefox )
	mozilla? ( www-client/mozilla )
	>=x11-libs/gtk+-2.4
	!www-client/pcmanxplug-in
	!virtual/pcmanx"
PROVIDE="virtual/pcmanx"

src_compile() {
	myconf=""
	use mozilla ||use firefox && myconf="$myconf --enable-plugin"
	
	econf $myconf || die "econf failed"
	
	emake || die "emake failed"
}

src_install()
{
	cd $S
	make DESTDIR=${D} install
}
resetplugin()
{
	use mozilla && /usr/lib/mozilla/regxpcom
	use firefox && /usr/lib/mozilla-firefox/regxpcom
}

pkg_postinst()
{
	resetplugin
}

pkg_postrm()
{
	resetplugin
}

pkg_preinst()
{
	if use firefox || use mozilla
	then
		use mozilla && web=mozilla
		use firefox && web=firefox
		use mozilla && use firefox && web="mozilla and firefox"

		einfo "You must restart $web to take effect."
		einfo "if still not effect, please remove compreg.dat in ~/<$web working directory> ."
	fi
}
