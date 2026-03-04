# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO="https://github.com/spatialaudio/python-sounddevice"
inherit distutils-r1 pypi

DESCRIPTION="Play and record sound with Python via PortAudio"
HOMEPAGE="
	https://github.com/spatialaudio/python-sounddevice
	https://pypi.org/project/sounddevice/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	dev-python/cffi[${PYTHON_USEDEP}]
	media-libs/portaudio
"
BDEPEND="
	dev-python/cffi[${PYTHON_USEDEP}]
"

# Tests require audio hardware
RESTRICT="test"
