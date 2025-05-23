# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GnuPG keyring of Archlinux developer keys"
HOMEPAGE="https://gitlab.archlinux.org/archlinux/archlinux-keyring"
#SRC_URI="https://sources.archlinux.org/other/${PN}/${P}.tar.gz"
SRC_URI="https://gitlab.archlinux.org/archlinux/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-2" # "GPL" for the Arch linux package
SLOT="0"

KEYWORDS="~amd64"
PATCHES="${FILESDIR}/01_adapt_to_sequoia_sq_0_34.patch"

BDEPEND=">=app-crypt/sequoia-sq-0.33.0"

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
