# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde eutils

DESCRIPTION="Graphical network monitor for the KDE panel"
SRC_URI="http://hftom.free.fr/knetmonapplet/${P}.tar.gz"
HOMEPAGE="http://hftom.free.fr/knetmonapplet/index.html"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="arts"

need-kde 3

src_unpack() {
	kde_src_unpack

	use arts || epatch "${FILESDIR}/${P}-noarts.patch"

	rm -f $S/knetmon/uiconfig.{h,cpp,moc}
}

