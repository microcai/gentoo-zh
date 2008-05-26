#Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:$ 

inherit eutils

DESCRIPTION="PCManX is an easy-to-use telnet client mainly targets BBS users formerly writen by gtk2"
HOMEPAGE="http://pcmanx.csie.net/"
RESTRICT="nomirror"

KEYWORDS="x86 ~ppc amd64"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""
PROVIDE=""

src_unpack()
{
	eerror "net-misc/pcmanx was obsolete and change to net-misc/pcmanx-gtk2 now."
	eerror "please uninstall net-misc/pcmanx and install net-misc/pcmanx-gtk2
	instead."
	die
}
