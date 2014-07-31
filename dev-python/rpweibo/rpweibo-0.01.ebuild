# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A Weibo API wrapper based on cURL + Python."
HOMEPAGE="https://github.com/WeCase/rpweibo"
SRC_URI="https://github.com/WeCase/rpweibo/archive/${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}
		dev-python/pycurl[${PYTHON_USEDEP}]"
RDEPEND="$DEPEND"

S="${WORKDIR}/rpweibo-${PV}"

python_install_all() {
	distutils-r1_python_install_all
}
