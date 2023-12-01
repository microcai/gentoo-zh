# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN=fcitx5-table-extra
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="Provides extra table for Fcitx, including Boshiamy, Zhengma, Cangjie, and Quick"
HOMEPAGE="https://github.com/fcitx/fcitx5-table-extra"
SRC_URI="https://download.fcitx-im.org/fcitx5/${MY_PN}/${MY_PN}-${PV}.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"

DEPEND="
	app-i18n/fcitx:5
	app-i18n/libime
"
RDEPEND="${DEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"
