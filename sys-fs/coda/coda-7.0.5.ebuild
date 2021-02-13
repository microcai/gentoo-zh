# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Coda is an advanced network file system, similar to NFS"
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="http://coda.cs.cmu.edu/coda/source/coda-7.0.5.tar.xz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COM_DEP="sys-libs/ncurses
	dev-lang/lua
	sys-devel/flex
	sys-devel/bison
	dev-lang/python
	sys-libs/readline
	sys-libs/lwp
"

DEPEND="${COM_DEP}
	virtual/pkgconfig
"

RDEPEND="${COM_DEP}"
BDEPEND=""


