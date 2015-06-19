# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="GTK+ interface for free online dict"
HOMEPAGE="http://rt.openfoundry.org/Foundry/Project/?Queue=848"
SRC_URI="http://rt.openfoundry.org/Foundry/Project/Download/Attachment/92913/63831/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="dev-lang/python
	dev-python/pygtk
	gnome-extra/gtkhtml"
RDEPEND="${DEPEND}"

src_install()
{
	cd ${S}
	make DESTDIR=${D} install || die
}
