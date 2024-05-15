# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN="yass"
DESCRIPTION="lightweight and efficient, socks5/http forward proxy"
HOMEPAGE="https://github.com/Chilledheart/yass"
SRC_URI="https://github.com/Chilledheart/yass/releases/download/${PV}/yass-${PV}.tar.bz2"
S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~loong ~mips ~riscv ~x86"

IUSE="+cli server +gui wayland +tcmalloc"

RDEPEND="
	app-misc/ca-certificates
	dev-libs/glib:2
	net-libs/mbedtls
	sys-libs/zlib
	net-dns/c-ares
	net-libs/nghttp2
	gui? (
		loong? (
			x11-libs/gtk+:3[wayland?]
		)
		!loong? (
			|| ( x11-libs/gtk+:3[wayland?] gui-libs/gtk:4[wayland?] )
		)
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/boringssl-gcc-14.patch
	"${FILESDIR}"/libcxx-gcc-14.patch
)

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR=/etc
		-DBUILD_SHARED_LIBS=off
		-DUSE_BUILTIN_CA_BUNDLE_CRT=off
		-DUSE_LIBCXX=on
		-DENABLE_GOLD=off
		-DCLI=$(usex cli)
		-DSERVER=$(usex server)
		-DGUI=$(usex gui)
		-DBUILD_TESTS=off
		-DUSE_TCMALLOC=$(usex tcmalloc)
		-DUSE_SYSTEM_MBEDTLS=on
		-DUSE_SYSTEM_ZLIB=on
		-DUSE_SYSTEM_CARES=on
		-DUSE_SYSTEM_NGHTTP2=on
	)
	cmake_src_configure
}
