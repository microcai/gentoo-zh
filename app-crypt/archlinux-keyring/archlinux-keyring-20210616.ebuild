# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GnuPG keyring of Archlinux developer keys"
HOMEPAGE="https://gitlab.archlinux.org/archlinux/archlinux-keyring"
SRC_URI="https://sources.archlinux.org/other/${PN}/${P}.tar.gz"
LICENSE="GPL-2" # "GPL" for the Arch linux package
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	# bluntly remove the makefile.
	rm -f Makefile || die "Couldn't remove Makefile"

	default
}

src_install() {
	# Take the directory of sys-apps/pacman to have a sane default of
	# upstream respectivly Archlinux.
	insinto /usr/share/pacman/keyrings/
	doins archlinux{.gpg,-trusted,-revoked}
}

pkg_postinst() {
	einfo ""
	einfo "This package only installs the keyring files while sys-apps/pacman"
	einfo "initializes these keyrings to actually use it. This is a different"
	einfo "behaviour from Archlinux, but is necessary to avoid circular deps."
	einfo ""
}
