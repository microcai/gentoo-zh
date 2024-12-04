# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 git-r3

DESCRIPTION="GUI for snapper, a tool for Linux filesystem snapshot management"
HOMEPAGE="https://github.com/ricardomv/snapper-gui"
EGIT_REPO_URI="https://github.com/ricardomv/${PN}.git"
EGIT_COMMIT=1915750

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	app-backup/snapper
	$(python_gen_cond_dep 'dev-python/dbus-python[${PYTHON_USEDEP}] dev-python/pygobject[${PYTHON_USEDEP}]')
	x11-libs/gtksourceview:3.0
"

src_prepare() {
	sed -i 's/Utilities;/Utility;/' "${S}/snapper-gui.desktop"
	default
}
