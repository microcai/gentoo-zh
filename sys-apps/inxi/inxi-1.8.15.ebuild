# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="A newer, better system information script for irc, administration, and system troubleshooters."
HOMEPAGE="http://code.google.com/p/inxi/"
SRC_URI="https://inxi.googlecode.com/svn/tarballs/inxi_${PV}.orig.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
app-shells/bash
sys-apps/coreutils
sys-apps/gawk
sys-apps/grep
sys-apps/pciutils
sys-process/procps
sys-apps/sed"

S=${WORKDIR} #just for the weird archive

src_install() {
	dobin ${PN}
	doman ${PN}.1.gz
}
