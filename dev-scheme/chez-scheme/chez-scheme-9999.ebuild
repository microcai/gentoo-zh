# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-r3

DESCRIPTION="Chez Scheme is an implementation of the Revised 6 Report on Scheme (R6RS) with numerous language and programming environment extensions."
HOMEPAGE="https://cisco.github.io/ChezScheme"

EGIT_REPO_URI="https://github.com/cisco/ChezScheme.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="+threads"

DEPEND="
	sys-libs/ncurses
	x11-libs/libX11
"

RDEPEND="${DEPEND}"

src_configure() {
        local para_thread

	if use threads ; then
	   para_thread="--threads"
	fi

	./configure \
	${para_thread} \
	--installprefix=/usr \
	--installbin=/usr/bin \
	--installlib=/usr/lib \
	--installman=/usr/share/man \
	--temproot=${D}
}

src_install() {
	emake install
}
