# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

MY_PN="fcitx5-bamboo"
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="Typing Vietnamese by Bamboo core engine for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-bamboo"
SRC_URI="https://download.fcitx-im.org/fcitx5/${MY_PN}/${MY_PN}-${PV}.tar.xz -> ${P}.tar.xz"

LICENSE="LGPL-2.1+ MIT"
SLOT="5"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	>=app-i18n/fcitx-5.1.5:5
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/go
	kde-frameworks/extra-cmake-modules:0
"
