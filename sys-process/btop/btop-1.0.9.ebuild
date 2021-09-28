# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Resource monitor showing usage and stats for cpu, ram, disks, network and processes. The C++ version"

HOMEPAGE="https://github.com/aristocratos/btop"
SRC_URI="https://github.com/aristocratos/btop/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0 "
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

BDEPEND=""

S="${WORKDIR}/${PN}-${PV}"

