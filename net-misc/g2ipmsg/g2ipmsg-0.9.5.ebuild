# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


inherit eutils

ESCRIPTION="This is a pop up style LAN Messenger for multi platforms." 
HOMEPAGE="http://www.ipmsg.org/index.html.en"    
SRC_URI="http://www.ipmsg.org/archive/${P}.tar.gz"    

SLOT="0"  
IUSE="linguas_zh_CN ssl applet systray" 
LICENSE="GPL-2" 
KEYWORDS="x86 amd64" 

DEPEND="gnome-base/libgnomeui \
		dev-libs/glib  \
		ssl? ( dev-libs/openssl ) \
		applet? ( >=gnome-base/gnome-panel-2 ) \
		virtual/pkgconfig \
    	>=dev-util/intltool-0.33 \
		>=x11-libs/gtk+-2.10.14"


RESTRICT="mirror"  #for overlay

src_unpack() 
{
	unpack ${A}
	cd "${S}"
	sed -i 's/CP932/CP936/g' configure.in
	sed -i 's/CP932/CP936/g' configure
}


src_compile()
{

	local myconf
	myconf="`use_enable systray` \
			`use_enable applet` \
			`use_with   ssl`"

	if use linguas_zh_CN ; then 
		myconf="$myconf --with-ext-charcode=CP936"
	fi
	einfo " myconf = ${myconf}"
	econf ${myconf} || die "=================econf failed============="
	emake || die "emake failed"
}

src_install()
{
	GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL=1 emake DESTDIR="${D}" install || die "emake install failed" #
}
