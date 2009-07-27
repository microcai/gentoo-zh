# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils subversion

DESCRIPTION="Platform independent MSN Messenger client written in Python+GTK"
HOMEPAGE="http://emesene.org/"
ESVN_REPO_URI="https://emesene.svn.sourceforge.net/svnroot/emesene/trunk/emesene"
ESVN_PATCHES="${PN}-r1387-aplay.patch"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS=""

DEPEND=">=dev-lang/python-2.4.3
	>=x11-libs/gtk+-2.8.20
	>=dev-python/pygtk-2.8.6"

RDEPEND="${DEPEND}
	dev-python/notify-python"

#S=${WORKDIR}/${PN}

src_unpack() {
	subversion_src_unpack
}


src_install() {
	insinto /usr/share/emesene
#	rm GPL PSF LGPL
	doins -r build/lib*/*
	echo -e '#!/bin/sh \n python /usr/share/emesene/Controller.py'>> emesene-start
	dobin emesene-start
	newicon "${S}"/themes/default/icon96.png ${PN}.png
	make_desktop_entry emesene-start "EmeSeNe" ${PN}.png
}

pkg_postinst() {
	einfo "If you want to report bugs, file a ticket at http://emesene.org/trac/newticket"
}
