# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
inherit python-r1 unpacker

DESCRIPTION="Deepin Wine Helper"
HOMEPAGE="https://www.deepin.org"

COMMON_URI="https://home-store-packages.uniontech.com/appstore/pool/appstore/d"
SRC_URI="${COMMON_URI}/${PN}/${PN}_${PV}-${PR/r/}_i386.deb"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="test"

RDEPEND="
	${PYTHON_DEPS}
	app-emulation/deepin-wine-plugin[virtual-pkg]
"
DEPEND="${RDEPEND}"

S=${WORKDIR}

QA_PREBUILT="opt/deepinwine/*"
QA_FLAGS_IGNORED="opt/deepinwine/*"

src_install() {
	python_fix_shebang -f "opt/deepinwine/tools/add_hotkeys"
	python_fix_shebang -f "opt/deepinwine/tools/get_tray_window"
	insinto /
	doins -r opt

	fperms 755 -R /opt/deepinwine/tools/
}
