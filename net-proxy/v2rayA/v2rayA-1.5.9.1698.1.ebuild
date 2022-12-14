# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd go-module desktop xdg

DESCRIPTION="web GUI of Project V which supports V2Ray, Xray, SS, SSR, Trojan and Pingtunnel"
HOMEPAGE="https://v2raya.org/"

SRC_URI="
	https://github.com/v2rayA/v2rayA/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
"
# maintainer generated vendor
# generated with https://github.com/liuyujielol/rei-overlay/blob/main/net-proxy/v2rayA/scripts/v2rayA_vendor_gen.sh
SRC_URI+="
	https://github.com/liuyujielol/vendors/releases/download/${PN}/${P}-yarn_mirror.tar.gz
	https://github.com/liuyujielol/vendors/releases/download/${PN}/${P}-go-deps.tar.gz
"
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+v2ray xray systemd"
REQUIRED_USE="|| ( v2ray xray )"
RESTRICT="mirror"

DEPEND=""
RDEPEND="
	${DEPEND}
	v2ray? ( || (
		<net-proxy/v2ray-5
		<net-proxy/v2ray-bin-5
	) )
	xray? ( >=net-proxy/Xray-1.4.3 )
"
BDEPEND="
	>=dev-lang/go-1.18:=
	>=net-libs/nodejs-14.17.5-r1
	sys-apps/yarn
"

YARN_WORKDIR="${S}/gui"

# ${P}.tar.gz => ${S}
# ${P}-yarn_mirror.tar.gz => ${WORKDIR}/yarn_offline_mirror
# ${P}-go-deps.tar.gz => ${WORKDIR}/go-mod
src_unpack() {
	unpack "${P}.tar.gz"
	unpack "${P}-yarn_mirror.tar.gz"
	unpack "${P}-go-deps.tar.gz"
}

src_prepare() {
	default
	if [[ -e ${YARN_WORKDIR} ]]; then
		cd "${YARN_WORKDIR}" || die
		# set yarn-offline-mirror to ${WORKDIR}/yarn_offline_mirror
		echo "yarn-offline-mirror \"${WORKDIR}/yarn_offline_mirror\"" >> "${YARN_WORKDIR}/.yarnrc" || die
		yarn install --offline --check-files || die "yarn offline install failed"
	fi

	# GOMODCACHE has already been set to ${WORKDIR}/go-mod by go-module.eclass
}

src_compile() {
	cd "${YARN_WORKDIR}" || die
	#Fix node build error: https://github.com/webpack/webpack/issues/14532#issuecomment-947012063
	export NODE_OPTIONS=--openssl-legacy-provider
	OUTPUT_DIR="${S}/service/server/router/web" yarn build || die "yarn build failed"

	for file in $(find "${S}/service/server/router/web" |grep -v png |grep -v index.html|grep -v .gz)
	do
		if [ ! -d $file ]; then
			gzip -9 $file
		fi
	done

	cd "${S}/service" || die
	ego build -ldflags "-X github.com/v2rayA/v2rayA/conf.Version=${PV} -s -w" -o v2raya
}

src_install() {
	dobin "${S}"/service/v2raya
	keepdir "/etc/v2raya"

	if use systemd; then
		systemd_dounit "${S}"/install/universal/v2raya.service
		systemd_dounit "${S}"/install/universal/v2raya-lite.service
	fi

	#thanks to @Universebenzene
	newinitd "${FILESDIR}/${PN}.initd" v2raya
	newinitd "${FILESDIR}/${PN}-user.initd" v2raya-user
	newconfd "${FILESDIR}/${PN}.confd" v2raya
	newconfd "${FILESDIR}/${PN}-user.confd" v2raya-user

	newicon -s 512 "${S}"/gui/public/img/icons/android-chrome-512x512.png v2raya.png
	domenu "${S}"/install/universal/v2raya.desktop
}
