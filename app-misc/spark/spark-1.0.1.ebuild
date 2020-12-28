# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="▁▂▃▅▂▇ in your shell"
HOMEPAGE="http://zachholman.com/spark/"
SRC_URI="https://github.com/holman/spark/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin spark
	if use doc ; then
		dodoc *.md
	fi
}
