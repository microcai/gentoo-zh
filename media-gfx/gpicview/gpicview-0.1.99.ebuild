# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A Simple and Fast Image Viewer for X"
HOMEPAGE="http://lxde.sourceforge.net/gpicview/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

RESTRICT="nomirror"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
DEPEND="=x11-libs/gtk+-2*"

src_install () {
	cd ${S}
	make DESTDIR=${D} install || die
}
