# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="嘉立创EDA"
HOMEPAGE="https://lceda.cn/"
SRC_URI="https://image.lceda.cn/files/lceda-linux-x64-${PV}.zip"

LICENSE="AS-IS"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/lceda-linux-x64"

src_install(){
    insinto /opt/lceda
    doins -r .
    fperms 0755 /opt/lceda/lceda
    insinto /usr/share/applications
    doins ${FILESDIR}/LCEDA.desktop
}
