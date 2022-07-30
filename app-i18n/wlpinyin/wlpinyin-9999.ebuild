# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Experimental chinese wayland input method(IME)"
HOMEPAGE="https://github.com/xhebox/wlpinyin"
LICENSE="MIT"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/xhebox/wlpinyin"
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
IUSE=""

DEPEND="
	app-i18n/librime
	dev-libs/wayland
	dev-libs/wayland-protocols
	x11-libs/libxkbcommon[wayland]
"
