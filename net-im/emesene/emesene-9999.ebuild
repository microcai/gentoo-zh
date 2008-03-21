
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

ESVN_REPO_URI="https://emesene.svn.sourceforge.net/svnroot/emesene/trunk/emesene"
ESVN_PROJECT="emesene"
ESVN_PATCHES="${FILESDIR}/emesene-switchboard.patch"

inherit subversion eutils

DESCRIPTION="Platform independent MSN Messenger client written in Python+GTK"
HOMEPAGE="http://www.emesene.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""


DEPEND="
	>=dev-lang/python-2.4.3
	>=x11-libs/gtk+-2.8.20
	>=dev-python/pygtk-2.8.6
	"

RDEPEND="${DEPEND}"


pkg_setup() {
	ewarn "This is a LIVE SVN ebuild."
	ewarn "That means there are NO promises it will work."
}

src_install() {
	cd ${S}
	dodir /usr/share/emesene
	insinto /usr/share/emesene
	doins -r ./*
	dodir /usr/bin
	exeinto /usr/bin
	echo -e '#!/bin/sh \n python /usr/share/emesene/Controller.py'>> emesene-start
	doexe emesene-start

	newicon ${S}/themes/default/icon96.png ${PN}.png
	make_desktop_entry emesene-start "EmeSeNe" ${PN}.png

}

pkg_postinst() {
	ewarn "Remember, this stuff is SVN only code so dont cry when"
	ewarn "I break you :)."
	ewarn "If you want to report bugs, go to our forum at http://emesene.org/forums"
}
