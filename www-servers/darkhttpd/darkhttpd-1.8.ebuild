# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="A small, static webserver"
HOMEPAGE="http://unix4lyfe.org/darkhttpd/"
SRC_URI="http://unix4lyfe.org/darkhttpd/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin ${PN}
}
