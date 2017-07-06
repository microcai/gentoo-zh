# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit fdo-mime versionator eutils python-single-r1

MY_VER="$(get_version_component_range 1-2)+git$(get_version_component_range 3)"
SRC_URI="http://packages.linuxdeepin.com/deepin/pool/main/p/${PN}/${PN}_${MY_VER}.tar.gz"

DESCRIPTION="Download library and tool for Linux Deepin project"
HOMEPAGE="http://www.linuxdeepin.com"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
		dev-python/gevent[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
		dev-python/setuptools[${PYTHON_USEDEP}]
		dev-util/intltool[${PYTHON_USEDEP}]"
S=${WORKDIR}/${PN}-${MY_VER}

src_install() {
	"${PYTHON}" setup.py install --root=${D} || die "Install failed"
}
