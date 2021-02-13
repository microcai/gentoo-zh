# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="BaiduPCS-Go"
EGO_PN="github.com/felixonmars/${MY_PN}"

if [[ ${PV} == *9999 ]]; then
	inherit golang-build golang-vcs
else
	inherit golang-build golang-vcs-snapshot

	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~arm ~arm64 ~mips"
fi

DESCRIPTION="The terminal utility for Baidu Network Disk (Golang Version)."
HOMEPAGE="https://github.com/felixonmars/BaiduPCS-Go"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	!net-misc/baidupcs-go-bin
"
BDEPEND=""

src_install() {
	newbin ${MY_PN} ${PN}
	dodoc src/${EGO_PN}/README*
}
