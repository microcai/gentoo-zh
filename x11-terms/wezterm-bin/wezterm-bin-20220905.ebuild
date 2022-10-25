# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

MY_R="102802-7d4b8249"
MY_PV="${PV}-${MY_R}"
MY_PN="${PN/-bin/}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="A terminal emulator and multiplexer implemented in Rust"
HOMEPAGE="https://wezfurlong.org/wezterm"

SRC_URI="https://github.com/wez/wezterm/releases/download/${MY_PV}/${MY_PN}-${MY_PV}.Ubuntu18.04.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="wayland +X"
REQUIRED_USE="|| ( wayland X )"

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	sys-apps/dbus
	>=media-libs/fontconfig-2.12
	>=dev-libs/openssl-1.1
	wayland? (
		dev-libs/wayland
		dev-libs/wayland-protocols
	)
	X? (
		>=x11-libs/libX11-1.7.5
		>=x11-libs/libxcb-1.8
		>=x11-libs/xcb-util-0.4
		>=x11-libs/xcb-util-wm-0.4.1
		>=x11-libs/xcb-util-image-0.2.1
		>=x11-libs/xcb-util-keysyms-0.4
		x11-libs/libxkbcommon[X]
	)
	x11-themes/hicolor-icon-theme
"

QA_PREBUILT="*"
S="${WORKDIR}/${MY_PN}"

src_install() {
	insinto /
	doins -r etc usr

	fperms 0755 -R /usr/bin/
	fperms 0755 -R /etc/profile.d/
}
