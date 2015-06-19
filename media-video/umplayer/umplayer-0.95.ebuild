# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit qt4-r2 subversion

DESCRIPTION="UMPlayer is cross-platform and installer packages are available for
the Windows, Mac and GNU / Linux operating systems. It is completely free to use
and distribute so feel free to share UMPlayer with all your friends."
HOMEPAGE="http://www.umplayer.com"
SRC_URI=""

ESVN_REPO_URI="https://${PN}.svn.sourceforge.net/svnroot/${PN}/${PN}/trunk@r172"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~86 ~mingw32"
IUSE=""

RDEPEND="
"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e 's/\$(QMAKE).\$(QMAKE_OPTS).\&\&.//' Makefile || die "Sed failed!"
	sed -i -e 's/PREFIX=\/usr\/local/PREFIX=\/usr/' Makefile || die "Sed failed!"
}

src_configure() {
	cd src/
	eqmake4
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die
}
