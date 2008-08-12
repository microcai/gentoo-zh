# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="PCMan is an easy-to-use telnet client mainly targets BBS users formerly writen by gtk2"
SRC_URI="http://pcmanx.csie.net/release/${P}.tar.bz2"
HOMEPAGE="http://pcmanx.csie.net/"
RESTRICT="nomirror"

KEYWORDS="x86 ~ppc amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="firefox wget libnotify"

DEPEND=">=x11-libs/gtk+-2.4
	x11-libs/libXft
	dev-util/intltool
	fireofx? ( www-client/mozilla-firefox )
	wget? ( net-misc/wget )
	libnotify? ( x11-libs/libnotify )
	!www-client/pcmanxplug-in
	!virtual/pcmanx"

PROVIDE="virtual/pcmanx"

src_unpack()
{
	unpack ${A}
	cd ${S}
#	epatch ${FILESDIR}/firefox-xpcom-fix-0.3.7.patch
}

src_compile() {
	myconf=""
	use firefox && myconf="$myconf --enable-plugin"
	use wget && myconf="$myconf --enable-wget"
	use libnotify && myconf="$myconf --enable-libnotify"
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
	use firefox && /usr/lib/mozilla-firefox/regxpcom
}

pkg_postinst()
{
	resetplugin
	if use firefox
	then
		web=firefox

		einfo "You must restart $web to take effect."
		einfo "if still not effect, please remove compreg.dat in ~/<$web working directory> ."
	fi
}

pkg_postrm()
{
	resetplugin
}
