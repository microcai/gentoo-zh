# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils git-r3

DESCRIPTION="A fast, safe VPN based on libsodium"
HOMEPAGE="http://shadowvpn.org/"

EGIT_REPO_URI="https://github.com/clowwindy/shadowvpn.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

DEPEND="dev-libs/libsodium"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e 's|SUBDIRS = ../libsodium||' \
		-e 's|AM_CFLAGS = .*libsodium.*$|AM_CFLAGS = -lsodium|' \
		-e 's|libshadowvpn_la_LIBADD = ../libsodium/src/libsodium/libsodium.la||' \
		-i src/Makefile.am

	sed -e 's|AC_CONFIG_SUBDIRS([libsodium])||' \
		-i configure.ac
}

src_configure() {
	./autogen.sh
	econf \
		--sysconfdir=/etc --disable-static --prefix=/usr
}
