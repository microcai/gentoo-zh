# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit toolchain-funcs qt4-r2 subversion

DESCRIPTION="UMPlayer is cross-platform and installer packages are available for
the Windows, Mac and GNU / Linux operating systems. It is completely free to use
and distribute so feel free to share UMPlayer with all your friends."
HOMEPAGE="http://www.umplayer.com"
SRC_URI=""

ESVN_REPO_URI="https://${PN}.svn.sourceforge.net/svnroot/${PN}/${PN}/trunk@r172"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~86 ~mingw32"
IUSE=""

RDEPEND="x11-libs/qt-core:4
x11-libs/qt-gui:4
dev-libs/glib:2
"
DEPEND="${RDEPEND}"

src_prepare(){
	echo CONF_PREFIX=/ >> Makefile
	echo REFIX=/usr >> Makefile
	echo CC="$(tc-getCC)" >> Makefile
	echo CXX=$(tc-getCXX) >> Makefile
	echo LD=$(tc-getLD) >> Makefile
	echo LINK='$LD' >> Makefile
}

src_compile(){
	emake CONF_PREFIX=/ PREFIX=/usr \
	CC=$(tc-getCC) CXX=$(tc-getCXX) LD=$(tc-getLD) LINK=$(tc-getLD) || die
}

src_install(){
	emake DESTDIR="${D}" INSTALL_ROOT="${D}" CONF_PREFIX=/ PREFIX=/usr install || die
}

