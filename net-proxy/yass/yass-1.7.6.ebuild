# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN="yass"
S="${WORKDIR}/${MY_PN}-${PV}"
SRC_URI="https://github.com/Chilledheart/yass/releases/download/${PV}/yass-${PV}.tar.gz"
KEYWORDS="amd64 ~arm64 ~x86"

DESCRIPTION="lightweight and efficient, socks5/http forward proxy"
HOMEPAGE="https://github.com/Chilledheart/yass"

LICENSE="GPL-2"
SLOT="0"
IUSE="wayland"

RDEPEND="
	app-misc/ca-certificates
	dev-libs/glib:2
	net-libs/mbedtls
	sys-libs/zlib
	net-dns/c-ares
	net-libs/nghttp2
	gui-libs/gtk:4[wayland?]
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=off
		-DUSE_BUILTIN_CA_BUNDLE_CRT=off
		-DUSE_LIBCXX=on
		-DENABLE_GOLD=off
		-DGUI=ON
		-DCLI=OFF
		-DSERVER=OFF
		-DBUILD_TESTS=off
		-DUSE_SYSTEM_MBEDTLS=on
		-DUSE_SYSTEM_ZLIB=on
		-DUSE_SYSTEM_CARES=on
		-DUSE_SYSTEM_NGHTTP2=on
	)
	cmake_src_configure
}
