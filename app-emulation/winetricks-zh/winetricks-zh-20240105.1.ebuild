# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake xdg

DESCRIPTION="windows applications setup wizard for Chinese wine users"
HOMEPAGE="https://github.com/hillwoodroc/winetricks-zh/"
SRC_URI="
	https://github.com/hillwoodroc/winetricks-zh/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-emulation/winetricks"
