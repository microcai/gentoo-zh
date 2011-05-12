# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils git

DESCRIPTION="Generates C++ man pages from cplusplus.com"
HOMEPAGE="https://github.com/Aitjcize/manpages-cpp/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/Aitjcize/manpages-cpp.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

PYTHON_MODNAME="cppman"

src_prepare() {
	sed -i -e "/'share\/doc'/d" setup.py || die "sed failed"
	sed -i -e 's/^cat.*/man "$1"/' lib/viewer.sh || die "sed failed"
}

src_install () {
	distutils_src_install
	rm ${ED}/usr/bin/cppman-* || die "rm failed"
}
