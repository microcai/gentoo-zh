
EAPI=3
inherit kde4-base 

DESCRIPTION="Fast and lightweight frontend for gdb"
HOMEPAGE="http://www.kgdb.org"
SRC_URI="mirror://sourceforge/${PN}/Source%20Code/${PV}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""


RDEPEND="kde-base/kdelibs"
DEPEND="${RDEPEND}
	dev-util/cmake"


