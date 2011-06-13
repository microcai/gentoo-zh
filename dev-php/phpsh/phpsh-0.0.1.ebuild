# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="An interactive shell for php"
HOMEPAGE="http://phpsh.org/"
SRC_URI="http://phpsh.org/phpsh-latest.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="FREEWARE"
IUSE=""

RDEPEND=""

src_install() {
	dodir /opt/bin

	into /opt
	dobin phpsh/ansicolor.py 
	dobin phpsh/ctags.py  
	dobin phpsh/phpsh 
	dobin phpsh/phpsh.php
}
