# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

MY_PN="ReText"

DESCRIPTION="ReText is a simple but powerful text editor for Markdown and reStructuredText"
HOMEPAGE="http://sourceforge.net/p/retext/home/ReText/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+markdown -rst +spell"

S="${WORKDIR}"

RDEPEND="dev-python/PyQt4
	markdown? ( dev-python/markdown )
	rst? ( dev-python/docutils )
	spell? ( dev-python/pyenchant ) "

pkg_setup(){
	use markdown || use rst || die "please enable at least markdown or rst"
}

src_install(){
	dodir /usr/share
	dodir /usr/share/${PN}
	dodir /usr/lib/${PN}
	dodir /usr/bin

	cp -a icons ${D}/usr/share/

	exeinto /usr/lib/${PN}

	doexe ${PN}.py

	cp -a wpgen ${D}/usr/lib/${PN}

	cp -a locale ${D}/usr/share/${PN}/

	dosym ../lib/${PN}/${PN}.py /usr/bin/${PN}

	make_desktop_entry "retext" "ReText Editor" "retext" "Development;Utility;TextEditor"

	dodoc README
}
