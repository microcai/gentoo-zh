# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A makefile generation tool"
HOMEPAGE="http://premake.berlios.de/"
SRC_URI="mirror://sourceforge/premake/${PN}-src-${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}/${P/p/P}

src_install() {
	dobin bin/premake
}
