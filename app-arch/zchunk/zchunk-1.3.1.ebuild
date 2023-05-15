# Copyright 2017-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson
if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/zchunk/zchunk.git"
	EGIT_CHECKOUT_DIR=${PN}-${PV}
else
	SRC_URI="https://github.com/zchunk/zchunk/archive/refs/tags/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
	KEYWORDS="~amd64 ~riscv"
	S="${WORKDIR}/${PN}-${PV}"
fi

DESCRIPTION="A format designed for highly efficient deltas while maintaining good compression"
HOMEPAGE="https://github.com/zchunk/zchunk"
LICENSE="BSD"
SLOT="0"
IUSE=""
RDEPEND=""
DEPEND="
	net-misc/curl
	app-arch/zstd
"
BDEPEND="${DEPEND}"
