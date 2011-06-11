# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="An interactive shell for php"
HOMEPAGE="http://phpsh.org/"
SRC_URI="http://phpsh.org/phpsh-latest.tgz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="FREEWARE"
IUSE=""

RDEPEND=""

S="${WORKDIR}"

src_unpack() {
	tar -xzf "${DISTDIR}/phpsh-latest.tgz" 
}

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	dodir /opt/bin

	into /opt
	dobin phpsh/ansicolor.py 
	dobin phpsh/ctags.py  
	dobin phpsh/phpsh 
	dobin phpsh/phpsh.php
}
