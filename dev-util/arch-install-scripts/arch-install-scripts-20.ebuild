# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Arch Linux install tools (pacstrap, genfstab, arch-chroot)"
HOMEPAGE="https://projects.archlinux.org/arch-install-scripts.git/"
SRC_URI="https://projects.archlinux.org/${PN}.git/snapshot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	sys-apps/pacman"

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}

