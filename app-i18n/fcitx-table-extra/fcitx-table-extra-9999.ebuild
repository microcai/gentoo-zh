# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/fcitx/fcitx-table-extra.git"
	FCITX_TABLE_EXTRA_SRC_URI=""
	FCITX_TABLE_EXTRA_ECLASS="git-2"
	KEYWORDS=""
else
	FCITX_TABLE_EXTRA_SRC_URI="http://fcitx.googlecode.com/files/${P}.tar.xz"
	RESTRICT="mirror"
	FCITX_TABLE_EXTRA_ECLASS="vcs-snapshot"
	KEYWORDS="~amd64 ~x86"
fi

inherit cmake-utils ${FCITX_TABLE_EXTRA_ECLASS}

DESCRIPTION="fcitx-table-extra provides extra table for Fcitx, including
Boshiamy, Zhengma, and Cangjie3, Cangjie5."
HOMEPAGE="https://fcitx.google.com"
SRC_URI="${FCITX_TABLE_EXTRA_SRC_URI}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.2.4[table]"
RDEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext"

src_unpack() {
	${FCITX_TABLE_EXTRA_ECLASS}_src_unpack
}
