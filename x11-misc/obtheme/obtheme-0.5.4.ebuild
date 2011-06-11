# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A GUI theme editor for Openbox."
HOMEPAGE="http://xyne.archlinux.ca/info/obtheme"
SRC_URI="http://xyne.archlinux.ca/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~x86"
IUSE=""

RESTRICT="primaryuri"

DEPEND="dev-lang/python
		dev-python/pygtk
		dev-python/fuse-python
		x11-libs/gtk+
		"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_install() {
	dobin ${PN} || die
}

pkg_postinst() {
	echo
	elog "-------------------------------"
	elog "set env XDG_CONFIG_HOME value"
	elog "~/.bash_profile /etc/profile"
	elog "-------------------------------"
	echo
}
