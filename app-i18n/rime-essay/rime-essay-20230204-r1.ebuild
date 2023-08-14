# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

EGIT_COMMIT="e0519d0579722a0871efb68189272cba61a7350b"
HANS_EGIT_COMMIT="dc06d4c96ae72ad46b29e3aa824a5d1e8f721fd0"
SRC_URI="
	hant? ( https://github.com/rime/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz )
	hans? ( https://github.com/rime/${PN}-simp/archive/${HANS_EGIT_COMMIT}.tar.gz -> ${P}-simp.tar.gz )
"
KEYWORDS="~amd64 ~arm64 ~x86"

DESCRIPTION="Essential files for building up your Rime configuration"
HOMEPAGE="https://github.com/rime/rime-essay"
LICENSE="LGPL-3"
SLOT="0"

DEPEND=">=app-i18n/rime-data-1"
RDEPEND="$DEPEND"

S="${WORKDIR}"

IUSE="+hans +hant"

src_install() {
	local dir="/usr/share/rime-data"
	insinto "$dir"

	if use hant; then
		mv ${PN}-${EGIT_COMMIT}/*.txt ./ || die
	fi

	if use hans; then
		mv ${PN}-simp-${HANS_EGIT_COMMIT}/*.txt ./ || die
	fi

	doins *.txt
}
