# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="userspace tools for SSDFS"
HOMEPAGE="https://github.com/dubeyko/ssdfs-tools"
SRC_URI="https://github.com/dubeyko/ssdfs-tools/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dubeyko/ssdfs-tools.git"
fi

inherit autotools

LICENSE="BSD"
SLOT="0"

RDEPEND="
	sys-apps/util-linux
	sys-libs/zlib
"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare(){
	eapply_user
	eautoreconf
}
