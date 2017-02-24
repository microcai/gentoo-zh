# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_DEPEND="2"

inherit distutils-r1

DESCRIPTION="dtrx: Intelligent archive extraction"
HOMEPAGE="http://brettcsmith.org/2007/dtrx/"
SRC_URI="http://brettcsmith.org/2007/dtrx/dtrx-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	DOCS="NEWS README"
	python_set_active_version 2
	python_pkg_setup
}
