# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1

DESCRIPTION="A library for detecting, labeling, and reasoning about microarchitectures"
HOMEPAGE="https://github.com/archspec/archspec"
SRC_URI="
	https://github.com/archspec/archspec/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/archspec/archspec-json/archive/v${PV}.tar.gz -> ${P}-json.tar.gz"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest

src_unpack() {
	default
	mv -u "${PN}-json-${PV}/cpu/" "${S}/${PN}/json" || die
}
