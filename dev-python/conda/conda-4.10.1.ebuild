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
		dev-python/pyopenssl
		dev-python/requests
		dev-python/ruamel-yaml
		dev-python/conda-package-handling
		dev-python/pycosat"
RDEPEND="${DEPEND}"
BDEPEND=""

IUSE="+user"

distutils_enable_tests pytest

src_prepare() {
	echo ${PV} > ${S}/conda/.version
	default
}

src_install() {
	distutils-r1_src_install "$@"
	rm "${D}/usr/bin/conda" || die
	cp "${S}/conda/shell/bin/conda" "${D}/usr/bin/conda" || die
	if use user ; then
		mkdir -p "${D}/etc/conda/" || die
		cp "${FILESDIR}/condarc" "${D}/etc/conda/condarc" || die
	fi
}

pkg_postinst() {
	elog "Initialize conda for shell interaction, "
	elog "run 'conda init shells' "
	elog "Currently compatible shells are {bash, fish, powershell, tcsh, xonsh, zsh}"
}
