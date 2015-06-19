# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="A fcitx module to look up pinyin candidate words on the internet"
HOMEPAGE="http://fcitx-im.org/"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/${PN}.git"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.2.8
	net-misc/curl"
DEPEND="${RDEPEND}
	virtual/libiconv
	virtual/libintl
	virtual/pkgconfig"
