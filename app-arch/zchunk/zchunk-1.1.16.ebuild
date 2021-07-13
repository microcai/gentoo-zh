# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson
SRC_URI="https://github.com/zchunk/zchunk/archive/refs/tags/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
KEYWORDS="~amd64"
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

S="${WORKDIR}/${PN}-${PV}"
