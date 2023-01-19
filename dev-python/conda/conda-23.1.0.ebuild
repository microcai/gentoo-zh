# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="OS-agnostic, system-level binary package manager and ecosystem"
HOMEPAGE="https://conda.io/"
SRC_URI="https://github.com/conda/conda/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-vcs/git
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/pluggy[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/ruamel-yaml[${PYTHON_USEDEP}]
		dev-python/toolz[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}]
		dev-python/conda-package-handling[${PYTHON_USEDEP}]
		dev-python/conda-package-streaming[${PYTHON_USEDEP}]
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
	cp "${S}/conda/shell/bin/conda" "${ED}/usr/bin/conda" || die
	# no need for Python Byte compiling and multi python slot, please do not use python_doscript
	# this ebuild just use one stable python target
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
	elog "base environment is managed by portage, do not use conda in base env!"
}
