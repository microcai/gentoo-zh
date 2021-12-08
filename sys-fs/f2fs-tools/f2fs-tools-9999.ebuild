# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Tools for Flash-Friendly File System (F2FS)"
HOMEPAGE="https://sourceforge.net/projects/f2fs-tools/"
SRC_URI=""

EGIT_REPO_URI="https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	default
	echo 'mkfs_f2fs_LDFLAGS = ' >> mkfs/Makefile.am
	eautoreconf
}

src_configure(){
	econf --disable-static
}
