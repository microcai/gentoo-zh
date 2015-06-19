# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit autotools git-2

DESCRIPTION="Library for Chinese Phonetic input method"
HOMEPAGE="http://chewing.im/"
EGIT_REPO_URI="git://github.com/chewing/${PN}.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
    virtual/pkgconfig
	"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable debug)
}

src_compile(){
	emake -j1 || die "make failed"
}

src_test() {
	# test subdirectory is not enabled by default; this means that we
	# have to make it explicit.
	emake -C test check || die "emake check failed"
}

src_install(){
	make install DESTDIR=${D} || die "install failed"
}
