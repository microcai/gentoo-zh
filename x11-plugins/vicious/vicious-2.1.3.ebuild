# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="Modular widget library for x11-wm/awesome"
HOMEPAGE="http://awesome.naquadah.org/wiki/Vicious"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="http://git.sysphere.org/${PN}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://git.sysphere.org/${PN}/snapshot/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="contrib"

DEPEND=""
RDEPEND="x11-wm/awesome"

src_install() {
	insinto /usr/share/awesome/lib/vicious
	doins -r widgets helpers.lua init.lua
	dodoc CHANGES README TODO

	if use contrib; then
		insinto /usr/share/awesome/lib/vicious/contrib
		doins contrib/*.lua
		newdoc contrib/README README.contrib
	fi
}
