# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils python

PYTHON_DEPEND=*

DESCRIPTION="Update live packages and emerge the modified ones"
HOMEPAGE="http://github.com/mgorny/smart-live-rebuild/"
SRC_URI="http://github.com/downloads/mgorny/${PN}/${P}.tar.bz2"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="primaryuri"

pkg_postinst() {
	elog "You might also consider installing [dev-python/psutil] then, which is required"
	elog "for ${PN} automatically detect if it was spawned by emerge."
}
