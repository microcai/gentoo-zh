# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header :$

ESVN_REPO_URI="http://egear.googlecode.com/svn/trunk/"

inherit qt4 subversion

DESCRIPTION="eGear, a download tool written in QT4"
HOMEPAGE="egear.googlecode.com"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/openssl
		net-misc/curl
		=dev-lang/python-2.5*
		|| (
			( x11-libs/qt-core x11-libs/qt-gui )
			( >=x11-libs/qt-4.3 )
		)"
RDEPEND="${DEPEND}"

RESTRICT="primaryuri"

src_compile() {
	eqmake4
	emake || die "emake fail"
}

src_install() {
	insinto /usr/share/pixmaps
	doins res/egear.png

	insinto /usr/share/applications
	doins misc/egear.desktop

	dobin ${PN}
}
