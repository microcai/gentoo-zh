# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PN=fcitx5-table-extra
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="Provides extra table for Fcitx, including Boshiamy, Zhengma, Cangjie, and Quick"
HOMEPAGE="https://github.com/fcitx/fcitx5-table-extra"
SRC_URI="https://github.com/fcitx/fcitx5-table-extra/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="5"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-i18n/fcitx:5
	app-i18n/libime
	sys-devel/gettext
"
RDEPEND="${DEPEND}"
BDEPEND="
	kde-frameworks/extra-cmake-modules
	virtual/pkgconfig
"
