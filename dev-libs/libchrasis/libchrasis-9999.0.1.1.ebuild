# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic eutils subversion

IUSE=""
DESCRIPTION="Library for Chinese Character Recognition As-Is"
HOMEPAGE="http://chrasis.berlios.de"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"
DEPEND="dev-cpp/libxmlpp
	>=dev-db/sqlite-3
	!dev-libs/libchrasis
	virtual/libc"
RDEPEND="${DEPEND}"

src_unpack() {
	for I in "download" "confirm";do
		ESVN_REPO_URI="svn://svn.berlios.de/chrasis/Engine/libchrasis/trunk"
		ESVN_PROJECT="libchrasis"
		#ESVN_PATCHES="*.diff"
		#ESVN_BOOTSTRAP="./autogen.sh"
		subversion_src_unpack
	done
}

src_compile() {
	glib-gettextize -f
	./autogen.sh
	econf || die "./configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make install DESTDIR=${D} || die "install failed"
} 
