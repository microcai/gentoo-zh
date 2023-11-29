# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN="fcitx5"
S="${WORKDIR}/${MY_PN}-${PV}"
SRC_URI="https://download.fcitx-im.org/fcitx5/fcitx5/fcitx5-${PV}_dict.tar.xz -> ${P}.tar.xz"
KEYWORDS="~amd64 ~arm64 ~loong ~riscv ~x86"

DESCRIPTION="Fcitx5 Next generation of fcitx "
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5"

LICENSE="LGPL-2+ Unicode-DFS-2016"
SLOT="5"
IUSE="+autostart coverage doc +emoji +enchant +keyboard presage +server systemd test wayland +X"
REQUIRED_USE="
	|| ( wayland X )
	X? ( keyboard )
	wayland? ( keyboard )
"

RESTRICT="!test? ( test )"

RDEPEND="
	doc? ( app-doc/doxygen )
	enchant? ( app-text/enchant:2 )
	emoji? ( sys-libs/zlib )

	keyboard? (
		app-text/iso-codes
		dev-libs/expat
		dev-libs/json-c:=
		x11-misc/xkeyboard-config
		x11-libs/libxkbcommon[X?,wayland?]
	)

	systemd? ( sys-apps/systemd )

	wayland? (
		dev-libs/wayland
		dev-libs/wayland-protocols
		dev-util/wayland-scanner
	)
	X? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXrender
		x11-libs/libXinerama
		x11-libs/libxkbfile
		x11-libs/xcb-util
		x11-libs/xcb-util-keysyms
		x11-libs/xcb-util-wm
		>=x11-libs/xcb-imdkit-1.0.3:5
	)

	dev-libs/libevent
	dev-libs/libfmt
	sys-apps/dbus
	virtual/libintl
	x11-libs/gdk-pixbuf:2
	x11-libs/cairo[X?]
	x11-libs/pango[X?]
"
DEPEND="
	${RDEPEND}
	test? (
		coverage? (
			dev-util/lcov
		)
	)
"
BDEPEND="
	virtual/pkgconfig
	kde-frameworks/extra-cmake-modules:0
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
		-DENABLE_DBUS=on
		-DENABLE_XDGAUTOSTART=$(usex autostart)
		-DENABLE_SERVER=$(usex server)
		-DENABLE_KEYBOARD=$(usex keyboard)
		-DENABLE_TEST=$(usex test)
		-DENABLE_COVERAGE=$(usex coverage)
		-DENABLE_ENCHANT=$(usex enchant)
		-DENABLE_EMOJI=$(usex emoji)
		-DENABLE_PRESAGE=$(usex presage)
		-DENABLE_WAYLAND=$(usex wayland)
		-DENABLE_X11=$(usex X)
		-DENABLE_DOC=$(usex doc)
		-DUSE_SYSTEMD=$(usex systemd)
	)
	cmake_src_configure
}

src_test() {
	# break by sandbox
	local CMAKE_SKIP_TESTS=(
		testdbus
		testservicewatcher
	)
	cmake_src_test
}

pkg_postinst() {
	xdg_pkg_postinst

	elog
	elog "Follow the instrcutions on:"
	elog "https://wiki.gentoo.org/wiki/Fcitx#Using_Fcitx"
	elog "https://fcitx-im.org/wiki/Setup_Fcitx_5"
	elog "https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland"
	elog
}
