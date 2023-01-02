# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GnuPG keyring of Archlinux developer keys"
HOMEPAGE="https://gitlab.archlinux.org/archlinux/archlinux-keyring"
#SRC_URI="https://sources.archlinux.org/other/${PN}/${P}.tar.gz"
SRC_URI="https://gitlab.archlinux.org/archlinux/${PN}/-/archive/${PV}/${P}.tar.gz"
LICENSE="GPL-2" # "GPL" for the Arch linux package
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
BDEPEND="app-crypt/sequoia-sq"

src_compile(){
	emake build
}

src_install(){
	emake PREFIX='/usr' DESTDIR="${D}" install
}

pkg_postinst() {
	einfo ""
	einfo "This package only installs the keyring files while sys-apps/pacman"
	einfo "initializes these keyrings to actually use it. This is a different"
	einfo "behaviour from Archlinux, but is necessary to avoid circular deps."
	einfo ""
}
