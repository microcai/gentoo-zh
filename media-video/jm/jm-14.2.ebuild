# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="H.264/AVC reference software"
HOMEPAGE="http://iphome.hhi.de/suehring/tml"
SRC_URI="http://iphome.hhi.de/suehring/tml/download/${P/-/}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/JM"

src_compile() {
	sh unixprep.sh
	emake || die "make failed"
}

src_install() {
	cd bin
	newbin ldecod.exe ldecod
	newbin lencod.exe lencod
}
