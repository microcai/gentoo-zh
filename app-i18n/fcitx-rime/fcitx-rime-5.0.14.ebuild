# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

DESCRIPTION="Rime Support for Fcitx5"
HOMEPAGE="https://github.com/fcitx/fcitx5-rime"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/fcitx5-rime.git"
else
	MY_PN="fcitx5-rime"
	S="${WORKDIR}/${MY_PN}-${PV}"
	SRC_URI="https://github.com/fcitx/fcitx5-rime/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="5"
IUSE=""

RDEPEND="app-i18n/fcitx:5
	>=app-i18n/librime-1.0
	>=app-i18n/rime-data-0.3.0
	app-i18n/rime-prelude
	x11-libs/libnotify"

DEPEND="${RDEPEND}"
