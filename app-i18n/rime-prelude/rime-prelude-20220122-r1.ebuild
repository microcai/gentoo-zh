# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

EGIT_COMMIT="4001edf96791bbb5663573ba79ba4b1e9c0b8626"
SRC_URI="https://github.com/rime/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~x86"

DESCRIPTION="Essential files for building up your Rime configuration"
HOMEPAGE="https://github.com/rime/rime-prelude"
LICENSE="GPL-3"
SLOT="0"

DEPEND=">=app-i18n/rime-data-1"
RDEPEND="$DEPEND"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

src_install() {
	local dir="/usr/share/rime-data"
	insinto "$dir"

	doins *.yaml
}
