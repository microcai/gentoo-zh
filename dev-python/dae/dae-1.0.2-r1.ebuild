# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 python-r1

DESCRIPTION="Deepin App Engine"
HOMEPAGE="https://github.com/linuxdeepin/dae"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE="
     ${PYTHON_REQUIRED_USE}"

DEPEND="dev-python/python-xlib[${PYTHON_USEDEP}]
		dev-python/PyQt5[${PYTHON_USEDEP},webkit,declarative,gui,network,printsupport,widgets,dbus]"
