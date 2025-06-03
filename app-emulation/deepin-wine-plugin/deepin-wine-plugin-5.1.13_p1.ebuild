# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..14} )
inherit unpacker python-r1

DESCRIPTION="Deepin Wine plugin"
HOMEPAGE="https://www.deepin.org"
MY_PV="${PV/_p/-}"

COMMON_URI="https://mirrors.sdu.edu.cn/spark-store-repository/store/depends"
SRC_URI="${COMMON_URI}/deepin-wine-series//${PN}_${MY_PV}_amd64.deb
		virtual-pkg? ( ${COMMON_URI}/deepin-wine-series/${PN}-virtual_${MY_PV}_all.deb )"

S=${WORKDIR}

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+virtual-pkg"
REQUIRED_USE="virtual-pkg? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	virtual-pkg? (
		app-arch/p7zip
		$(python_gen_cond_dep '
			dev-python/pydbus[${PYTHON_USEDEP}]
		')
		${PYTHON_DEPS}
	)
"

QA_PREBUILT="/usr/lib/i386-linux-gnu/deepin-wine* /usr/share/doc/*"
QA_FLAGS_IGNORED="/usr/lib/i386-linux-gnu/deepin-wine* /usr/share/doc/*"

src_install() {
	insinto /
	doins -r usr
}
