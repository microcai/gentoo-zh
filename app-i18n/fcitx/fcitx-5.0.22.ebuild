# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/fcitx5.git"
else
	MY_PN="fcitx5"
	S="${WORKDIR}/${MY_PN}-${PV}"
	SRC_URI="https://github.com/fcitx/fcitx5/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~loong ~x86"
fi

DESCRIPTION="Fcitx5 Next generation of fcitx "
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5"
SRC_URI+=" https://download.fcitx-im.org/data/en_dict-20121020.tar.gz -> fcitx-data-en_dict-20121020.tar.gz"

LICENSE="BSD-1 GPL-2+ LGPL-2+ MIT Unicode-DFS-2016"
SLOT="5"
IUSE="+enchant +emoji test coverage doc presage systemd wayland +X"
REQUIRED_USE="
	|| ( wayland X )
	coverage? ( test )
"

RESTRICT="!test? ( test )"

RDEPEND="
	test? (
		coverage? (
			dev-util/lcov
		)
	)

	doc? (
		app-doc/doxygen
	)

	dev-libs/expat
	dev-libs/glib:2
	sys-apps/dbus
	dev-libs/json-c
	dev-libs/libfmt
	sys-apps/util-linux
	virtual/libiconv
	virtual/libintl
	x11-libs/libxkbcommon[X?,wayland?]
	wayland? (
		dev-libs/wayland
		dev-libs/wayland-protocols
	)
	X? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXrender
		x11-libs/libXinerama
		x11-libs/libxkbfile
		x11-libs/libxcb
		x11-libs/xcb-util
		x11-libs/xcb-util-keysyms
		x11-libs/xcb-util-wm
		>=x11-libs/xcb-imdkit-1.0.3
	)
	x11-misc/xkeyboard-config
	x11-libs/cairo[X?]
	x11-libs/pango[X?]
	media-libs/fontconfig
	enchant? ( app-text/enchant:2 )
	systemd? ( sys-apps/systemd )
	app-text/iso-codes

	dev-libs/libxml2
	dev-libs/libevent
	x11-libs/gdk-pixbuf:2
"
DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig
"

src_unpack() {
	if [[ "${PV}" == 9999 ]]; then
		git-r3_src_unpack
	else
		# avoid unpacking fcitx-data-en_dict-20121020.tar.gz
		unpack "${P}.tar.gz"
	fi
}

src_prepare() {
	ln -s "${DISTDIR}/fcitx-data-en_dict-20121020.tar.gz" src/modules/spell/en_dict-20121020.tar.gz || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
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

pkg_postinst() {
	xdg_pkg_postinst

	elog
	elog "Follow the instrcutions of https://wiki.gentoo.org/wiki/Fcitx#Using_Fcitx"
	elog "and change the fcitx to fcitx5"
	elog
}
