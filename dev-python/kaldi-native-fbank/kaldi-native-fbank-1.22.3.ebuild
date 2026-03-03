# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=standalone
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="Kaldi-compatible online fbank feature extractor"
HOMEPAGE="
	https://github.com/csukuangfj/kaldi-native-fbank
	https://pypi.org/project/kaldi-native-fbank/
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

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist mirror strip test"

QA_PREBUILT="*"

python_compile() {
	local pyver="${EPYTHON/python/}"
	pyver="${pyver/./}"
	local pytag="cp${pyver}"
	local abitag="${pytag}-manylinux2014_x86_64.manylinux_2_17_x86_64"
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/$(pypi_wheel_name "${PN}" "${PV}" "${pytag}" "${abitag}")"
}
