# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

EGIT_COMMIT="c7618f4f5728e1634417e9d02ea50d82b71956ab"
SRC_URI="https://github.com/rime/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~x86"

DESCRIPTION="Bopomofo input for rime"
HOMEPAGE="https://github.com/rime/rime-bopomofo"
LICENSE="LGPL-3"
SLOT="0"

DEPEND="
	app-i18n/rime-cangjie
	app-i18n/rime-terra-pinyin
	>=app-i18n/rime-data-1
"
RDEPEND="$DEPEND"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

src_install() {
	local dir="/usr/share/rime-data"
	insinto "$dir"

	doins *.yaml
}
