#Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/ebuildteam/net-misc/pcmanx/pcmanx-0.3.3-r1.ebuild,v 1.1 2005/11/11 02:13:05 scsi Exp $

inherit eutils

DESCRIPTION="PCMan is an easy-to-use telnet client mainly targets BBS users formerly writen by gtk2"
SRC_URI="http://pcmanx.csie.net/release/pcmanx-pure-gtk2-${PV}.tar.gz"
HOMEPAGE="http://pcmanx.csie.net/"
RESTRICT="nomirror"

S="${WORKDIR}/pcmanx-pure-gtk2-${PV}"

KEYWORDS="x86 ~ppc amd64"
SLOT="0"
LICENSE="GPL"
IUSE="mozilla firefox"

DEPEND=">=x11-libs/gtk+-2.4
	virtual/x11
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
	if  use mozilla || use firefox 
	then
		if [ -d $D/usr/lib/mozilla ]
		then
			mv $D/usr/lib/mozilla $D/usr/lib/web
		elif [ -d $D/usr/lib/firefox ]
		then
			mv $D/usr/lib/mozilla-firefox $D/usr/lib/web
		else
			die "no plugin file found."
		fi
		rm -rf $D/usr/lib/mozilla $D/usr/lib/mozilla-firefox >/dev/null 2>&1
		chmod +x $D/usr/lib/web/plugins/pcmanx-plugin.so
	
		use mozilla && (einfo "install mozlla plugin"; cp -r $D/usr/lib/web $D/usr/lib/mozilla)
		use firefox && (einfo "install firefox plugin";cp -r $D/usr/lib/web $D/usr/lib/mozilla-firefox)
		rm -rf $D/usr/lib/web  2>&1
	fi
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
