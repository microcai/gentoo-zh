# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils autotools

DESCRIPTION="T9 input engine using ibus"
HOMEPAGE="http://code.google.com/p/${PN}"
EGIT_REPO_URI="git://github.com/microcai/${PN}.git"

SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="+nls"

RDEPEND="
	>=app-i18n/ibus-1.2
	nls? ( virtual/libintl )
	"


DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( >=sys-devel/gettext-0.16.1 )"

src_install(){
	emake install DESTDIR=${D} || die
}




