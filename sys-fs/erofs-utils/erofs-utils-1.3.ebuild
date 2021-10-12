# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Userspace tools for EROFS images"
HOMEPAGE="https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git"
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/snapshot/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm arm64 mips ppc ppc64 riscv x86"
IUSE="fuse lz4 selinux +uuid"

RDEPEND="
	fuse? ( sys-fs/fuse:0 )
	lz4? ( >=app-arch/lz4-1.9 )
	selinux? ( sys-libs/libselinux )
	uuid? ( sys-apps/util-linux )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable fuse) \
		$(use_enable lz4) \
		$(use_with selinux) \
		$(use_with uuid)
}

src_install() {
	default
	use fuse || rm "${ED}/usr/share/man/man1/erofsfuse.1" || die
}