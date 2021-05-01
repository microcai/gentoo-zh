# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 go-module

DESCRIPTION="GeoIP generator for V2Ray."
HOMEPAGE="https://github.com/v2fly/geoip http://www.maxmind.com/"
EGIT_REPO_URI="https://github.com/v2fly/geoip.git"

LICENSE="CC-BY-SA-4.0"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.16:="

src_unpack() {
	git-r3_src_unpack
	#TODO: Looking for a more elegant way to download deps
	export GOPROXY="https://goproxy.cn,direct" || die
	go-module_live_vendor
}

src_compile() {
	go build -v -work -o ${PN} -trimpath ./main.go || die
}

src_install() {
	exeinto /usr/bin
	doexe ${PN}
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog
		elog "run:"
		elog "  ${PN} -help"
		elog "to check the usage."
		elog
		elog "The original data files can be downloaded from:"
		elog "https://dev.maxmind.com/geoip/geoip2/geolite2/"
		elog "You need to sign up a maxmind account."
		elog
	fi
}
