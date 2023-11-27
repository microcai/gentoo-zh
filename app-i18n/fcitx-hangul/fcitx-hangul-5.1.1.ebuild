# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Korean Hangul input method for Fcitx"
HOMEPAGE="https://fcitx-im.org/ https://github.com/fcitx/fcitx5-hangul"

MY_PN="fcitx5-hangul"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://download.fcitx-im.org/fcitx5/${MY_PN}/${MY_P}.tar.xz"
S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS="~amd64 ~x86"

BDEPEND="sys-devel/gettext
	virtual/pkgconfig"
DEPEND=">=app-i18n/fcitx-5.0.2:5
	>=app-i18n/libhangul-0.0.12
	virtual/libiconv
	virtual/libintl"
RDEPEND="${DEPEND}"

DOCS=(AUTHORS)
