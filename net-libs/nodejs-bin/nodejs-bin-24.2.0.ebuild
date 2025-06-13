# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CONFIG_CHECK="~ADVISE_SYSCALLS"

inherit linux-info pax-utils

DESCRIPTION="A JavaScript runtime built on Chrome's V8 JavaScript engine"
HOMEPAGE="https://nodejs.org/"
SRC_URI="https://nodejs.org/dist/v${PV}/node-v${PV}-linux-x64.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/node-v${PV}-linux-x64"

LICENSE="Apache-1.1 Apache-2.0 BSD BSD-2 MIT Artistic-2"

SLOT="0"
KEYWORDS="-* ~amd64"

IUSE="doc"

RDEPEND="
	!net-libs/nodejs
	>=app-arch/brotli-1.1.0:=
	dev-db/sqlite:3
	>=dev-libs/libuv-1.49.2:=
	>=dev-libs/simdjson-3.10.1:=
	>=net-dns/c-ares-1.34.4:=
	>=net-libs/nghttp2-1.64.0:=
	>=net-libs/nghttp3-1.7.0:=
	sys-libs/zlib
	>=dev-libs/icu-73:=
	>=net-libs/ngtcp2-1.9.1:=
	>=dev-libs/openssl-1.1.1:0=
	sys-devel/gcc:*"

DEPEND="${RDEPEND}"

src_install(){
	dobin "${S}"/bin/node
	pax-mark -m "${ED}"/usr/bin/node

	insinto /usr/lib
	doins -r "${S}"/lib/*

	dosym ../lib/node_modules/corepack/dist/corepack.js /usr/bin/corepack
	dosym ../lib/node_modules/npm/bin/npm-cli.js /usr/bin/npm
	dosym ../lib/node_modules/npm/bin/npx-cli.js /usr/bin/npx
	fperms +x /usr/lib/node_modules/npm/bin/{npm-cli.js,npx-cli.js} /usr/lib/node_modules/corepack/dist/corepack.js

	doheader -r "${S}"/include/*

	keepdir /etc/npm
	echo "NPM_CONFIG_GLOBALCONFIG=${EPREFIX}/etc/npm/npmrc" > "${T}"/50npm
	doenvd "${T}"/50npm

	if use doc; then
		dodoc -r "${S}"/share/doc/*
		doman "${S}"/share/man/man1/node.1
		doman "${S}"/lib/node_modules/npm/man{1,5,7}/*
	fi
}
