# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN="fcitx5-chewing"
DESCRIPTION="Chewing Wrapper for Fcitx."
HOMEPAGE="https://github.com/fcitx/fcitx5-chewing"
SRC_URI="https://download.fcitx-im.org/fcitx5/${MY_PN}/${MY_PN}-${PV}.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~riscv"

BDEPEND="virtual/pkgconfig"
RDEPEND="
	>=app-i18n/fcitx-5.0.2:5
	>=app-i18n/libchewing-0.5.0
"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_PN}-${PV}"
