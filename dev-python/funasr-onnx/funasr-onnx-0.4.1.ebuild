# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_PN="funasr_onnx"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="FunASR ONNX Runtime inference for speech recognition"
HOMEPAGE="
	https://github.com/modelscope/FunASR
	https://pypi.org/project/funasr-onnx/
"

SRC_URI="
	https://files.pythonhosted.org/packages/19/ad/08ccdabd46d443c613ddfc6903cb68ac71f966b8bf4eb974d1c06e2b7520/${MY_P}.tar.gz
"

S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/librosa[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/kaldi-native-fbank[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	sci-ml/sentencepiece[${PYTHON_USEDEP}]
	dev-python/onnxruntime[${PYTHON_USEDEP}]
"

# Tests not included in PyPI tarball
RESTRICT="test"
