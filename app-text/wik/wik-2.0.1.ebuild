# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Wikipedia like a man - in the terminal, without images, with caching"
HOMEPAGE="
	https://github.com/yashsinghcodes/wik
	https://pypi.org/project/wik/
"
SRC_URI="https://github.com/yashsinghcodes/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
"

pkg_postinst() {
	einfo "Usage example:"
	einfo "wik -c batumi"
}
