# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

DESCRIPTION="OS-agnostic, system-level binary package manager and ecosystem"
HOMEPAGE="https://conda.io/"
SRC_URI="https://github.com/conda/conda/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-vcs/git
		$(python_gen_cond_dep '
		dev-python/archspec[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/pluggy[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/ruamel-yaml[${PYTHON_USEDEP}]
		dev-python/toolz[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}]
		dev-python/truststore[${PYTHON_USEDEP}]
		dev-python/jsonpatch[${PYTHON_USEDEP}]
		dev-python/conda-package-handling[${PYTHON_USEDEP}]
		dev-python/conda-package-streaming[${PYTHON_USEDEP}]
		pycosat? ( dev-python/pycosat[${PYTHON_USEDEP}] )')
		mamba? ( dev-python/conda-libmamba-solver[${PYTHON_SINGLE_USEDEP}] )"
RDEPEND="${DEPEND}"

IUSE="+user +mamba pycosat"
REQUIRED_USE="|| ( mamba pycosat )"

distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}/conda-23.11.0-remove-tests.patch"
)

python_prepare_all() {
	echo ${PV} > conda/.version || die
	sed -i "s/deprecated.topic(\"24.3\", \"24.9\")//g" conda/shell/bin/conda || die
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
		echo "$(cat "${FILESDIR}/condarc.user")" >> "${T}/condarc" || die
	fi
	# conda use libmamba as default solver
	if ! use mamba; then
		echo "$(cat "${FILESDIR}/condarc.classic")" >> "${T}/condarc" || die
	fi
	insinto /etc/conda
	doins "${T}/condarc"
}

pkg_postinst() {
	elog "Initialize conda for shell interaction, "
	elog "run 'conda init shells' "
	elog "Currently compatible shells are {bash, fish, powershell, tcsh, xonsh, zsh}"
	elog "base environment is managed by portage, do not use conda in base env!"
}
