# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Yunio"
HOMEPAGE="http://www.yunio.com"
SRC_URI="x86? ( http://www.yunio.com/download/${P}-generic-i386.tgz )
       amd64? ( http://www.yunio.com/download/${P}-generic-amd64.tgz )  "

LICENSE="FreeWare"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"


src_install() {
  cp "${S}"/yunio "${D}"
}
