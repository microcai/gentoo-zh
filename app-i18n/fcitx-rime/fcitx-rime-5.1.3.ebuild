# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="Rime Support for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-rime"

MY_PN="fcitx5-rime"
S="${WORKDIR}/${MY_PN}-${PV}"
SRC_URI="https://github.com/fcitx/fcitx5-rime/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~x86"

LICENSE="GPL-2"
SLOT="5"

RDEPEND="
	>=app-i18n/fcitx-5.1.5:5
	>=app-i18n/librime-1.0
	>=app-i18n/rime-data-0.3.0
	app-i18n/rime-prelude
	x11-libs/libnotify"

DEPEND="${RDEPEND}"
