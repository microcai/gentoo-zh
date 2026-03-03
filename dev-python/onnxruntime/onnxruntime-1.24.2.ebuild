# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=standalone
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="Cross-platform, high performance ML inferencing and training accelerator"
HOMEPAGE="
	https://onnxruntime.ai
	https://github.com/microsoft/onnxruntime
	https://pypi.org/project/onnxruntime/
"

SRC_URI="
	python_targets_python3_11? (
		https://files.pythonhosted.org/packages/2c/32/4e5921ba8b82ac37cad45f1108ca6effd430f49c7f20577d53f317d166ed/${PN}-${PV}-cp311-cp311-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl
	)
	python_targets_python3_12? (
		https://files.pythonhosted.org/packages/35/af/ad86cfbfd65d5a86204b3a30893e92c0cf3f1a56280efc5a12e69d81f52d/${PN}-${PV}-cp312-cp312-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl
	)
	python_targets_python3_13? (
		https://files.pythonhosted.org/packages/ac/62/6f2851cf3237a91bc04cdb35434293a623d4f6369f79836929600da574ba/${PN}-${PV}-cp313-cp313-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl
	)
	python_targets_python3_14? (
		https://files.pythonhosted.org/packages/0d/74/a1913b3a0fc2f27fe1751e9545745a3f35fd7833e3438a4208b4e215778f/${PN}-${PV}-cp314-cp314-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl
	)
"

S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/flatbuffers[${PYTHON_USEDEP}]
	>=dev-python/numpy-2[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/sympy[${PYTHON_USEDEP}]
"

RESTRICT="bindist mirror strip test"

QA_PREBUILT="*"

python_compile() {
	local pyver="${EPYTHON/python/}"
	pyver="${pyver/./}"
	local pytag="cp${pyver}"
	local abitag="${pytag}-manylinux_2_27_x86_64.manylinux_2_28_x86_64"
	distutils_wheel_install "${BUILD_DIR}/install" \
		"${DISTDIR}/$(pypi_wheel_name "${PN}" "${PV}" "${pytag}" "${abitag}")"
}
