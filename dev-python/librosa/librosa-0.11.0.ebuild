# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO="https://github.com/librosa/librosa"
inherit distutils-r1 pypi

DESCRIPTION="Python library for audio and music analysis"
HOMEPAGE="
	https://github.com/librosa/librosa
	https://pypi.org/project/librosa/
"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/audioread-2.1.9[${PYTHON_USEDEP}]
	>=dev-python/numba-0.51.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.22.3[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/scikit-learn-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/joblib-1.0[${PYTHON_USEDEP}]
	>=dev-python/decorator-4.3.0[${PYTHON_USEDEP}]
	>=dev-python/soundfile-0.12.1[${PYTHON_USEDEP}]
	>=dev-python/pooch-1.1[${PYTHON_USEDEP}]
	>=dev-python/soxr-0.3.2[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.1.1[${PYTHON_USEDEP}]
	>=dev-python/lazy-loader-0.1[${PYTHON_USEDEP}]
	>=dev-python/msgpack-1.0[${PYTHON_USEDEP}]
"

# Tests require librosa-test-data git submodule (~157MB) not in sdist
RESTRICT="test"

src_prepare() {
	default

	# Remove deprecated license classifier
	sed -i "/License ::/d" setup.cfg || die
}
