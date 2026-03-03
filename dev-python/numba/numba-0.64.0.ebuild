# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=standalone
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="NumPy-aware optimizing compiler for Python using LLVM"
HOMEPAGE="
	https://github.com/numba/numba
	https://pypi.org/project/numba/
"

SRC_URI="
	python_targets_python3_11? (
		$(pypi_wheel_url ${PN} ${PV} "cp311" "cp311-manylinux2014_x86_64.manylinux_2_17_x86_64")
	)
	python_targets_python3_12? (
		$(pypi_wheel_url ${PN} ${PV} "cp312" "cp312-manylinux2014_x86_64.manylinux_2_17_x86_64")
	)
	python_targets_python3_13? (
		$(pypi_wheel_url ${PN} ${PV} "cp313" "cp313-manylinux2014_x86_64.manylinux_2_17_x86_64")
	)
	python_targets_python3_14? (
		$(pypi_wheel_url ${PN} ${PV} "cp314" "cp314-manylinux2014_x86_64.manylinux_2_17_x86_64")
	)
"

S="${WORKDIR}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/llvmlite-0.46.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.22[${PYTHON_USEDEP}]
"

RESTRICT="bindist mirror strip test"

QA_PREBUILT="*"

python_compile() {
	local pyver="${EPYTHON/python/}"
	pyver="${pyver/./}"
	local pytag="cp${pyver}"
	local abitag="${pytag}-manylinux2014_x86_64.manylinux_2_17_x86_64"
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/$(pypi_wheel_name "${PN}" "${PV}" "${pytag}" "${abitag}")"

	# Remove optional threading backends with unresolvable soname deps
	# (libgomp for OpenMP, libtbb for TBB); numba works without them
	rm -f "${BUILD_DIR}"/install/usr/lib/python*/site-packages/numba/np/ufunc/{omppool,tbbpool}*.so || true
}
