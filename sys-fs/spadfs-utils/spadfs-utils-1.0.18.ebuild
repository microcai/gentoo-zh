# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="Filesystem Tools for SpadFS"
HOMEPAGE="http://www.jikos.cz/~mikulas/spadfs/"
SRC_URI="http://www.jikos.cz/~mikulas/spadfs/download/spadfs-1.0.18.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/spadfs-${PV}"

src_compile() {
	emake mkspadfs spadfsck
}

src_install() {
	dobin mkspadfs
	dobin spadfsck
}
