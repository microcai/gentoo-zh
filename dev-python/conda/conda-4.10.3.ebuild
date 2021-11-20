# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_9 )
inherit distutils-r1

DESCRIPTION="OS-agnostic, system-level binary package manager and ecosystem"
HOMEPAGE="https://conda.io/"
SRC_URI="https://github.com/conda/conda/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="dev-vcs/git
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/ruamel-yaml[${PYTHON_USEDEP}]
		dev-python/conda-package-handling[${PYTHON_USEDEP}]
		dev-python/pycosat[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="+user"

distutils_enable_tests pytest

python_prepare_all() {
	echo ${PV} > conda/.version || die
	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install
	rm "${ED}/usr/bin/conda" || die
	python_doscript conda/shell/bin/conda
}

python_install_all() {
	if use user ; then
		insinto /etc/conda
		doins "${FILESDIR}/condarc"
	fi
}

pkg_postinst() {
	elog "Initialize conda for shell interaction, "
	elog "run 'conda init shells' "
	elog "Currently compatible shells are {bash, fish, powershell, tcsh, xonsh, zsh}"
}
