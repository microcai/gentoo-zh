# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Data resources for Rime Input Method Engine"
HOMEPAGE="https://rime.im/ https://github.com/rime/plum"
EGIT_REPO_URI="https://github.com/rime/plum.git"

LICENSE="GPL-3 LGPL-3 extra? ( Apache-2.0 CC-BY-4.0 )"
SLOT="0"
KEYWORDS=""
IUSE="extra"

src_install() {
	insinto "/usr/share/rime-data"

	# Install basic packages
	local basic_pkgs=(
		"essay"
		"bopomofo"
		"cangjie"
		"luna-pinyin"
		"prelude"
		"stroke"
		"terra-pinyin"
	)

	for pkg in "${basic_pkgs[@]}"; do
		if [[ -d "${S}/packages/${pkg}" ]]; then
			doins -r "${S}/packages/${pkg}"/*
		fi
	done

	# Install extra packages if requested
	if use extra; then
		local extra_pkgs=(
			"array"
			"cantonese"
			"combo-pinyin"
			"double-pinyin"
			"emoji"
			"ipa"
			"middle-chinese"
			"pinyin-simp"
			"quick"
			"scj"
			"soutzoe"
			"stenotype"
			"wubi"
			"wugniu"
		)

		for pkg in "${extra_pkgs[@]}"; do
			if [[ -d "${S}/packages/${pkg}" ]]; then
				doins -r "${S}/packages/${pkg}"/*
			fi
		done
	fi
}
