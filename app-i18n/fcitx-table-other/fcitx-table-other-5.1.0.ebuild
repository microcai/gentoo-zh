# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN=fcitx5-table-other
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="Provides some other tables for Fcitx, fork from ibus-table-others, scim-tables"
HOMEPAGE="https://github.com/fcitx/fcitx5-table-other"
SRC_URI="https://download.fcitx-im.org/fcitx5/${MY_PN}/${MY_PN}-${PV}.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"

DEPEND="
	app-i18n/fcitx:5
	app-i18n/libime
	sys-devel/gettext
"
RDEPEND="${DEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules:0
	virtual/pkgconfig
"
