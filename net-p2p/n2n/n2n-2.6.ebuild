# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Layer Two Peer-to-Peer VPN"

inherit user systemd cmake

HOMEPAGE="http://www.ntop.org/n2n/"
SRC_URI="https://github.com/ntop/n2n/archive/2.6.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup n2n
	enewuser n2n -1 -1 /var/empty n2n
}

src_configure(){
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	keepdir /var/log/n2n
	fowners n2n:n2n /var/log/n2n

	cp ${S}/packages/etc/systemd/system/edge@.service.in ${S}/packages/etc/systemd/system/n2n-edge@.service
	cp ${S}/packages/etc/systemd/system/supernode.service.in ${S}/packages/etc/systemd/system/n2n-supernode.service

	systemd_dounit ${S}/packages/etc/systemd/system/n2n-edge@.service
	systemd_dounit ${S}/packages/etc/systemd/system/n2n-supernode.service

	cp ${S}/packages/etc/n2n/edge.conf.sample ${S}/packages/etc/n2n/edge-example.conf

	insinto /etc/n2n

	doins ${S}/packages/etc/n2n/edge-example.conf
	doins ${S}/packages/etc/n2n/supernode.conf.sample
}
