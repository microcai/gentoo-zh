# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit unpacker python-r1

DESCRIPTION="Deepin Wine plugin"
HOMEPAGE="https://www.deepin.org"

COMMON_URI="https://cdn-package-store6.deepin.com/appstore/pool/appstore/d"
SRC_URI="${COMMON_URI}/deepin-wine-helper/${PN}_${PV}-${PR/r/}_amd64.deb
		virtual-pkg? ( ${COMMON_URI}/deepin-wine-helper/${PN}-virtual_${PV}-${PR/r/}_all.deb )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+virtual-pkg"

DEPEND=""
RDEPEND="${DEPEND}
	virtual-pkg? (
		app-arch/p7zip
		$(python_gen_cond_dep '
			dev-python/pydbus[${PYTHON_USEDEP}]
		')
	)
"

S=${WORKDIR}

src_install() {
	insinto /
	doins -r usr
}
