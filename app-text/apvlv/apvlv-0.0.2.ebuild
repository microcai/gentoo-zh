# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils 

MY_P="${P}-bug-fix-1"
DESCRIPTION="a PDF Viewer whose behaviour like Vi. "
HOMEPAGE="http://code.google.com/p/apvlv/"
SRC_URI="http://apvlv.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTICT="primaryuri"

DEPEND=">=x11-libs/gtk+-2.6
		 >=app-text/poppler-0.5.1 
	"
RDEPEND="${DEPEND}"

#S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR="${D}" install || die
}
