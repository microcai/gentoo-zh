# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1

DESCRIPTION="Pure Python API for Maxmind's binary GeoIP databases."
HOMEPAGE="https://github.com/appliedsec/pygeoip"
SRC_URI="https://github.com/appliedsec/pygeoip/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
