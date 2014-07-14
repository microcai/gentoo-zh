# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit vcs-snapshot

DESCRIPTION="Linux tool to show progress for cp, rm, dd, ..."
HOMEPAGE="https://github.com/Xfennec/cv"
SRC_URI="https://github.com/Xfennec/cv/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin cv
}
