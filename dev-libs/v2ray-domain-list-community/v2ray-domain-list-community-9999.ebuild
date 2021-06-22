# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="Community managed domain list for V2Ray."
HOMEPAGE="https://github.com/v2fly/domain-list-community"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/v2fly/domain-list-community.git"
else
	EGO_SUM=(
		# module deps for non-live version
		)
	go-module_set_globals
	SRC_URI="https://github.com/v2fly/domain-list-community/archive/refs/tags/${PV#*_p}.tar.gz -> ${P}.tar.gz
		${EGO_SUM_SRC_URI}"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR%/}/${PN#v2ray-}-${PV#*_p}"
fi

LICENSE="MIT"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	!dev-libs/v2ray-domain-list-community-bin
	!<net-proxy/v2ray-4.38.3
"
BDEPEND=">=dev-lang/go-1.16"

src_unpack() {
	if [[ ${PV} == *9999 ]]; then
		git-r3_src_unpack
		#TODO: Looking for a more elegant way to download deps
		export GOPROXY="https://goproxy.cn,direct" || die
		go-module_live_vendor
	else
		go-module_src_unpack
	fi
}

src_compile() {
	go run ./
}

src_install() {
	insinto /usr/share/v2ray
	newins dlc.dat geosite.dat
}

pkg_postinst() {
	:
}
