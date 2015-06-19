# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit distutils

MY_P="${P/tool/Tool}"

DESCRIPTION="jToolkit is a Python web application framework built on modpython and Apache"
HOMEPAGE="http://jtoolkit.sourceforge.net/"
SRC_URI="http://jtoolkit.sourceforge.net/snapshots/${MY_P}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="mirror"

S=${WORKDIR}/${MY_P}

src_unpack(){
	unpack ${A}
	cd "${S}"
	ln -sf jToolkitSetup.py setup.py
}
