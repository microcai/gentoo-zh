# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A Layer Two Peer-to-Peer VPN"

inherit systemd cmake

HOMEPAGE="http://www.ntop.org/n2n/"
SRC_URI="https://github.com/ntop/n2n/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="+openssl"

DEPEND="
	acct-user/n2n
	acct-group/n2n
	openssl? ( dev-libs/openssl )
"
RDEPEND="${DEPEND}"

src_configure(){
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DN2N_OPTION_USE_OPENSSL=$(usex openssl ON OFF)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	rm -r "${D}/usr/share" || die
	doman "${S}/edge.8"
	doman "${S}/n2n.7"
	doman "${S}/supernode.1"

	keepdir /var/log/n2n

	cp "${S}/packages/etc/systemd/system/edge@.service.in" "${S}/packages/etc/systemd/system/n2n-edge@.service"
	cp "${S}/packages/etc/systemd/system/supernode.service.in" "${S}/packages/etc/systemd/system/n2n-supernode.service"

	systemd_dounit "${S}/packages/etc/systemd/system/n2n-edge@.service"
	systemd_dounit "${S}/packages/etc/systemd/system/n2n-supernode.service"

	cp "${S}/packages/etc/n2n/edge.conf.sample" "${S}/packages/etc/n2n/edge-example.conf"

	insinto /etc/n2n

	doins "${S}/packages/etc/n2n/edge-example.conf"
	doins "${S}/packages/etc/n2n/supernode.conf.sample"
}
