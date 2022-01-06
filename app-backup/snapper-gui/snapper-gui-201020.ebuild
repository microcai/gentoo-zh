# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_SINGLE_IMPL=y
inherit distutils-r1 git-r3

DESCRIPTION="GUI for snapper, a tool for Linux filesystem snapshot management"
HOMEPAGE="https://github.com/ricardomv/snapper-gui"
KEYWORDS="~amd64"
EGIT_REPO_URI="https://github.com/ricardomv/${PN}.git"
EGIT_COMMIT=f0c67ab

LICENSE="GPL-2+"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=""
RDEPEND="
	${DEPEND}
	app-backup/snapper
	$(python_gen_cond_dep 'dev-python/dbus-python[${PYTHON_USEDEP}] dev-python/pygobject[${PYTHON_USEDEP}]')
	x11-libs/gtksourceview:3.0
"

src_prepare() {
	sed -i 's/Utilities;/Utility;/' "${S}/snapper-gui.desktop"
	default
}