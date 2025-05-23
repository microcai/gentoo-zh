# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# see examples at sci-chemistry/gromacs/gromacs's ebuild files
CMAKE_MAKEFILE_GENERATOR="ninja"

inherit cmake unpacker xdg

DESCRIPTION="lightweight and efficient, socks5/http forward proxy"
HOMEPAGE="https://github.com/Chilledheart/yass"
SRC_URI="https://github.com/Chilledheart/yass/releases/download/${PV}/${PN}-${PV}.tar.zst"
S="${WORKDIR}/${PN}-${PV}"
LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="amd64 ~arm ~arm64 ~loong ~mips ~riscv ~x86"
#FIXME pkgcheck cries on NonsolvableDepsInDev on mips, no idea why
KEYWORDS="amd64 ~arm ~arm64 ~loong ~riscv ~x86"

IUSE="+cli server test cet gui gtk3 gtk4 qt5 qt6 wayland +tcmalloc mimalloc"

# tested with FEATURES="-network-sandbox test"
# tested with FEATURES="network-sandbox test"
# tested with FEATURES="test"
RESTRICT="!test? ( test )"

REQUIRED_USE="
	cet? ( ^^ ( amd64 x86 ) )
	gui? ( || ( gtk3 gtk4 qt5 qt6 ) )
	tcmalloc? ( !mimalloc )
"

PDEPEND="
	app-misc/ca-certificates
"

RDEPEND="
	net-libs/mbedtls
	sys-libs/zlib
	net-dns/c-ares
	net-libs/nghttp2
	dev-libs/jsoncpp
	tcmalloc? ( dev-util/google-perftools )
	mimalloc? ( dev-libs/mimalloc )
	gui? (
		gtk3? (
			dev-libs/glib:2
			x11-libs/gtk+:3[wayland?]
		)
		gtk4? (
			dev-libs/glib:2
			gui-libs/gtk:4[wayland?]
		)
		qt5? (
			dev-qt/qtcore:5
			dev-qt/qtgui:5
			dev-qt/qtwidgets:5
			wayland? ( dev-qt/qtwayland:5 )
		)
		qt6? (
			dev-qt/qtbase:6=[dbus,gui,widgets,wayland?]
			wayland? ( dev-qt/qtwayland:6 )
		)
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-lang/perl
	dev-lang/go
	>=dev-build/cmake-3.13.4
	app-alternatives/ninja
	virtual/pkgconfig
	gui? (
		gtk3? (
			sys-devel/gettext
		)
		gtk4? (
			sys-devel/gettext
		)
	)
	test? ( net-misc/curl )
"

src_prepare() {
	cmake_src_prepare
	# some tests require network access, comment it out if not supported
	if has network-sandbox ${FEATURES}; then
		sed -i -e 's/BUILD_TESTS_NO_NETWORK/BUILD_TESTS/g' "${S}/CMakeLists.txt"
	fi
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR=/etc
		-DBUILD_SHARED_LIBS=off
		-DUSE_LIBCXX=off
		-DCLI=$(usex cli)
		-DSERVER=$(usex server)
		-DUSE_CET=$(usex cet)
		-DBUILD_TESTS=$(usex test)
		-DUSE_TCMALLOC=$(usex tcmalloc)
		-DUSE_SYSTEM_TCMALLOC=$(usex tcmalloc)
		-DUSE_MIMALLOC=$(usex mimalloc)
		-DUSE_SYSTEM_MIMALLOC=$(usex mimalloc)
		-DUSE_SYSTEM_MBEDTLS=on
		-DUSE_ZLIB=on
		-DUSE_SYSTEM_ZLIB=on
		-DUSE_CARES=on
		-DUSE_SYSTEM_CARES=on
		-DUSE_SYSTEM_NGHTTP2=on
		-DUSE_JSONCPP=on
		-DUSE_SYSTEM_JSONCPP=on
	)

	if use qt6; then
		mycmakeargs+=( -DGUI=ON -DUSE_QT6=ON )
	elif use qt5; then
		mycmakeargs+=( -DGUI=ON -DUSE_QT5=ON )
	elif use gtk4; then
		mycmakeargs+=( -DGUI=ON -DUSE_GTK4=ON )
	elif use gtk3; then
		mycmakeargs+=( -DGUI=ON -DUSE_GTK4=OFF )
	else
		mycmakeargs+=( -DGUI=OFF )
	fi

	cmake_src_configure
}
