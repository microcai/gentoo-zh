# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils bash-completion-r1

DESCRIPTION="Dynamic Kernel Module Support"
SRC_URI="http://linux.dell.com/dkms/permalink/${P}.tar.gz"
HOMEPAGE="http://linux.dell.com/dkms"
LICENSE="GPL-2"
DEPEND=""
RDEPEND="app-arch/rpm"
KEYWORDS="*"
SLOT="0"

src_compile() {
	return
}

src_install() {
	make DESTDIR="$D" install
}
