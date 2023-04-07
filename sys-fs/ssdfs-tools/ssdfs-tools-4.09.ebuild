# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="userspace tools for SSDFS"
HOMEPAGE="https://github.com/dubeyko/ssdfs-tools"
SRC_URI="https://github.com/dubeyko/ssdfs-tools/archive/refs/tags/v${PV}.zip -> $P.zip"

if [[ ${PV} != *9999* ]] ; then
	EGIT_COMMIT=v${PV}
	KEYWORDS="amd64"
else
	KEYWORDS="~amd64"
fi

inherit autotools

LICENSE="MIT"
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
