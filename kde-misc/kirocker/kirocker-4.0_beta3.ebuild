# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kde

DESCRIPTION="Make your Kicker (the KDE main panel) rock with your music."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=52869"
SRC_URI="http://slaout.linux62.org/kirocker/${P/_beta/Beta}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="media-sound/amarok"

need-kde 3.2

S=${WORKDIR}/${P/_beta/Beta}

#src_unpack() {
#	unpack ${A}
#}

#src_compile() {
#	./configure --prefix=$(kde-config --prefix)
#	if [ -f Makefile ] || [ -f GNUmakefile ] || [ -f makefile ]; then emake || die "emake failed"
#	fi

#}


