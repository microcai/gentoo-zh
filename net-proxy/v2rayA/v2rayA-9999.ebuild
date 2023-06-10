# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd go-module desktop xdg git-r3

DESCRIPTION="web GUI of Project V which supports V2Ray, Xray, SS, SSR, Trojan and Pingtunnel"
HOMEPAGE="https://v2raya.org/"

EGIT_REPO_URI="https://github.com/v2rayA/v2rayA.git"
EGIT_BRANCH="feat_v5" # HEAD

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="xray"
RESTRICT="mirror"

DEPEND=""
RDEPEND="
	${DEPEND}
	|| (
		>=net-proxy/v2ray-5
		>=net-proxy/v2ray-bin-5
	)
	xray? ( net-proxy/Xray )
"
BDEPEND="
	>=dev-lang/go-1.19:*
	>=net-libs/nodejs-16
	sys-apps/yarn
"

src_unpack() {
	git-r3_src_unpack

	# requires network
	cd "${S}/gui" || die
	#yarn config set registry https://registry.npmmirror.com || die
	yarn install --ignore-engines --check-files || die "yarn install failed"

	# requires network
	cd "${S}/service" || die
	#ego env -w GOPROXY=https://goproxy.cn,direct
	ego mod vendor
}

src_compile() {
	cd "${S}/gui" || die
	## Fix node build error: https://github.com/webpack/webpack/issues/14532#issuecomment-947012063
	if has_version '>=dev-libs/openssl-3'; then
		export NODE_OPTIONS=--openssl-legacy-provider
	fi
	OUTPUT_DIR="${S}/service/server/router/web" yarn build || die "yarn build failed"

	for file in $(find "${S}/service/server/router/web" |grep -v png |grep -v index.html|grep -v .gz)
	do
		if [ ! -d $file ]; then
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

	# generate default config
	cat <<-EOF > "${S}"/v2raya || die
	# v2raya config example
	# Everything has defaults so you only need to uncomment things you want to
	# change
	EOF
	./service/v2raya --report config | sed '1,6d' | fold -s -w 78 | sed -E 's/^([^#].+)/# \1/'\
		>> "${S}"/v2raya || die

	# config /etc/default/v2raya
	insinto "/etc/default"
	doins "${S}"/v2raya

	systemd_dounit "${S}"/install/universal/v2raya.service
	systemd_douserunit "${S}"/install/universal/v2raya-lite.service

	#thanks to @Universebenzene
	newinitd "${FILESDIR}/${PN}.initd" v2raya
	newinitd "${FILESDIR}/${PN}-user.initd" v2raya-user
	newconfd "${FILESDIR}/${PN}.confd" v2raya
	newconfd "${FILESDIR}/${PN}-user.confd" v2raya-user

	newicon -s 512 "${S}"/gui/public/img/icons/android-chrome-512x512.png v2raya.png
	domenu "${S}"/install/universal/v2raya.desktop
}

pkg_postinst() {
	xdg_pkg_postinst

	if has_version '<net-proxy/v2rayA-2.0.0' ; then
		elog "Starting from net-proxy/v2rayA-2.0.0"
		elog "Support for v2ray-4 & xray has been dropped"
		elog "A config migration may be required"
	fi
}
