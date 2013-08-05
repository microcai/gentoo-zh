# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="云诺，传文件的最佳工具"
HOMEPAGE="http://www.yunio.com"
SRC_URI="x86? ( http://www.yunio.com/download/${P}-generic-i386.tgz )
       amd64? ( http://www.yunio.com/download/${P}-generic-amd64.tgz )  "

LICENSE="Other"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# we can not mirror it
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

QA_PRESTRIPPED="opt/yunio/yunio"

S=${WORKDIR}
src_install() {
  exeinto /opt/yunio
	doexe ${S}/yunio
	dodir /usr/bin
	dosym  /opt/yunio/yunio /usr/bin/yunio
	make_desktop_entry "/opt/yunio/yunio" "Yunio" "" "Network"
}
