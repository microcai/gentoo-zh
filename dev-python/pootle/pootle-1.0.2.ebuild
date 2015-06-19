# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit distutils

MY_P=${P/pootle/Pootle}

DESCRIPTION="PO-based Online Translation / Localization Engine"
HOMEPAGE="http://translate.sourceforge.net/"
SRC_URI="mirror://sourceforge/translate/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="mirror"


DEPEND="=dev-python/translate-toolkit-1.0.1
	dev-python/kid
	dev-python/jtoolkit
	dev-python/psyco"

S="${WORKDIR}/${MY_P}"

src_unpack(){
	unpack ${A}
	cd "${S}"
	ln -sf pootlesetup.py setup.py
}
