# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SRC_URI="
	rime? ( https://github.com/cubercsl/$PN/releases/download/v$PV/rime-flypy.tar.gz -> $P.tar.gz )
	fcitx? ( https://github.com/cubercsl/$PN/releases/download/v$PV/fcitx5-table-flypy.tar.gz -> $P-fcitx.tar.gz )
"
KEYWORDS="~amd64 ~arm64 ~x86"

DESCRIPTION="flypy-full input for rime"
HOMEPAGE="https://github.com/cubercsl/rime-flypy"
LICENSE="all-rights-reserved"
SLOT="0"

IUSE="+rime fcitx"

DEPEND="
	rime? ( app-i18n/rime-luna-pinyin )
	rime? ( app-i18n/rime-cangjie )
	rime? ( app-i18n/rime-prelude )
	fcitx? ( app-i18n/fcitx-chinese-addons )
"
RDEPEND="$DEPEND"
S="$WORKDIR"

src_install() {
	if use fcitx; then
		local fcitx_dir=/usr/share/fcitx5
		insinto $fcitx_dir/inputmethod/
		doins flypy.conf
		insinto $fcitx_dir/table/
		doins flypy.dict
		rm flypy.conf flypy.dict || die
	fi

	local dir="/usr/share/rime-data"
	insinto "$dir"

	doins -r *
}
