# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{3_2,3_3} )

inherit distutils-r1

DESCRIPTION="A SDK for Sina Weibo, WeCase's fork."
HOMEPAGE="https://github.com/WeCase/sinaweibopy"
SRC_URI="https://github.com/WeCase/sinaweibopy/archive/${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""

S="${WORKDIR}/sinaweibopy-${PV}"

python_install_all() {
	distutils-r1_python_install_all
}
