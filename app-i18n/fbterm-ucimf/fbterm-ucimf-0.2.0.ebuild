# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils 

DESCRIPTION="UCIMF input method support for FbTerm"
HOMEPAGE="http://ucimf.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/ucimf/fbterm_ucimf-0.2.0.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="app-i18n/fbterm app-i18n/libucimf"

src_unpack() {
	unpack ${A}

	SRCDIR="$(dirname ${S})"
	S="${SRCDIR}/fbterm_ucimf-0.2.0"
}

src_install() {
	emake DESTDIR="${D}" install || die
}

