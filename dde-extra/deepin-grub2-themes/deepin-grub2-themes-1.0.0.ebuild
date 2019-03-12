# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit mount-boot

DESCRIPTION="Deepin theme for GRUB2"
HOMEPAGE="https://github.com/linuxdeepin/deepin-grub2-themes"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-SA-4.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

src_prepare() {
	default
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	emake DESTDIR=${D} install
}
