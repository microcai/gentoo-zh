# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for LoongArch old-world compatibility"

SLOT="0"
KEYWORDS="~loong"

RDEPEND="|| (
	app-emulation/liblol
)"
