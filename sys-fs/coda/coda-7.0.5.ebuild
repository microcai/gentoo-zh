# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_11 )
inherit python-single-r1

DESCRIPTION="Coda is an advanced network file system, similar to NFS"
HOMEPAGE="
	http://www.coda.cs.cmu.edu
	https://github.com/cmusatyalab/coda
"
SRC_URI="http://coda.cs.cmu.edu/coda/source/${P}.tar.xz"

LICENSE="GPL-1"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="mirror"

COM_DEP="sys-libs/ncurses
	dev-lang/lua
	sys-devel/flex
	sys-devel/bison
	sys-libs/readline
	sys-libs/lwp
"

DEPEND="${COM_DEP}
	virtual/pkgconfig
"

RDEPEND="
	${COM_DEP}
	${PYTHON_DEPS}
"
