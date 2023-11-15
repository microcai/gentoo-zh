# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="LTFS for LTO tapes"
HOMEPAGE="https://github.com/LinearTapeFileSystem/ltfs"
EGIT_REPO_URI="https://github.com/LinearTapeFileSystem/ltfs.git"

if [[ ${PV} != *9999* ]] ; then
	EGIT_COMMIT=v${PV}
	KEYWORDS="amd64"
else
	KEYWORDS="~amd64"
fi

inherit git-r3 autotools

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-libs/libxml2
	dev-libs/icu
	sys-fs/fuse:0
	net-analyzer/net-snmp
"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	eapply_user
	eautoreconf
}
