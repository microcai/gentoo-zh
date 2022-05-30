# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN="fcitx5-chewing"
DESCRIPTION="Chewing Wrapper for Fcitx."
HOMEPAGE="https://github.com/fcitx/fcitx5-chewing"
SRC_URI="https://github.com/fcitx/fcitx5-chewing/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS="~amd64"

BDEPEND="virtual/pkgconfig"
RDEPEND="
	app-i18n/fcitx:5
	>=app-i18n/libchewing-0.5.0
"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_PN}-${PV}"
