# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Super Symlink Manager"
HOMEPAGE="https://github.com/peeweep/supersm"
if [[ "${PV}" != *9999 ]] ; then
	SRC_URI="https://github.com/peeweep/supersm/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/peeweep/supersm"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv"

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"
