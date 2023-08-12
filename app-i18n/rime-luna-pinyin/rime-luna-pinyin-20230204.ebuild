# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

EGIT_COMMIT="79aeae200a7370720be98232844c0715f277e1c0"
SRC_URI="https://github.com/rime/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~x86"

DESCRIPTION="Luna pinyin for rime"
HOMEPAGE="https://github.com/rime/rime-luna-pinyin"
LICENSE="LGPL-3"
SLOT="0"

DEPEND="
	app-i18n/rime-stroke
	>=app-i18n/rime-data-1
"
RDEPEND="$DEPEND"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

src_install() {
	local dir="/usr/share/rime-data"
	insinto "$dir"

	doins *.yaml
}
