# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils subversion

DESCRIPTION="An environment for authoring TeX (LaTeX, ConTeXt, etc) documentsfor casual and non-technical users."

HOMEPAGE="http://code.google.com/p/texworks"

ESVN_REPO_URI="http://texworks.googlecode.com/svn/trunk/"
ESVN_PATCHES=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=x11-libs/qt-core-4.5.0
	 >=virtual/poppler-0.10.6
	 >=virtual/poppler-qt4-0.10.6
	 >=app-text/hunspell-1.2.2"

src_compile() {
	qmake || die "TeXworks qmake failed!"
	make || die "TeXworks make failed!"
}

src_install() {
	dobin texworks
	insinto /usr/share/applications
	doins "${FILESDIR}"/texworks.desktop || die "Install texwork.desktop failed!"
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/icon/texworks.png || die "Install texwork icon failed!"
}
