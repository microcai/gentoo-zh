# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools git-r3

DESCRIPTION="The ABI Generic Analysis and Instrumentation Library"
HOMEPAGE="https://www.sourceware.org/libabigail/"
SRC_URI=""

EGIT_REPO_URI="git://sourceware.org/git/libabigail.git"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/elfutils
dev-libs/libxml2"

RDEPEND="${DEPEND}"

DEPEND="${DEPEND}
virtual/pkgconfig
sys-devel/autoconf
"

src_prepare(){
	eautoreconf
}
