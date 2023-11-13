# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd go-module desktop xdg

DESCRIPTION="web GUI of Project V which supports V2Ray, Xray, SS, SSR, Trojan and Pingtunnel"
HOMEPAGE="https://v2raya.org/"

SRC_URI="
	https://github.com/v2rayA/v2rayA/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/v2rayA/v2rayA/releases/download/v${PV}/web.tar.gz -> ${P}-web.tar.gz
"
# maintainer generated vendor
# generated with liuyujielol/gentoo-go-deps/.github/workflows/generator.yml
SRC_URI+="
	https://github.com/liuyujielol/gentoo-go-deps/releases/download/${P}/${P}-vendor.tar.xz
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="xray"
RESTRICT="mirror"

RDEPEND="
	|| (
		>=net-proxy/v2ray-5
		>=net-proxy/v2ray-bin-5
	)
	xray? ( net-proxy/Xray )
"
BDEPEND="
	>=dev-lang/go-1.21:*
"

src_unpack() {
	default

	# go vendor
	mv -v "${WORKDIR}/vendor" "${S}/service" || die
}

src_compile() {
	mv -v "${WORKDIR}/web" "${S}/service/server/router/web" || die

	for file in $(find "${S}/service/server/router/web" |grep -v png |grep -v index.html|grep -v .gz)
	do
		if [ ! -d $file ];then
			einfo "compress $file"
			gzip -9 $file
		fi
	done

	cd "${S}/service" || die
	ego build -mod vendor -ldflags "-X github.com/v2rayA/v2rayA/conf.Version=${PV} -s -w" -o v2raya
}

src_install() {
	dobin "${S}"/service/v2raya
	# directory for runtime use
	keepdir "/etc/v2raya"

	./service/v2raya --report config | sed '1,6d' | fold -s -w 78 | sed -E 's/^([^#].+)/# \1/'\
		>> "${S}"/install/universal/v2raya.default || die

	# config /etc/default/v2raya
	insinto "/etc/default"
	newins "${S}"/install/universal/v2raya.default v2raya

	systemd_dounit "${S}"/install/universal/v2raya.service
	systemd_douserunit "${S}"/install/universal/v2raya-lite.service

	#thanks to @Universebenzene
	newinitd "${FILESDIR}/${PN}.initd" v2raya
	newinitd "${FILESDIR}/${PN}-user.initd" v2raya-user
	newconfd "${FILESDIR}/${PN}.confd" v2raya
	newconfd "${FILESDIR}/${PN}-user.confd" v2raya-user

	doicon -s 512 "${S}"/install/universal/v2raya.png
	domenu "${S}"/install/universal/v2raya.desktop
}

pkg_postinst() {
	xdg_pkg_postinst

	if has_version '<net-proxy/v2rayA-2.0.0' ; then
		elog "Starting from net-proxy/v2rayA-2.0.0"
		elog "Support for v2ray-4 has been dropped"
		elog "A config migration may be required"
	fi
}
