# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Modular initramfs image creation utility"
HOMEPAGE="https://github.com/archlinux/mkinitcpio"

SRC_URI="https://github.com/archlinux/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPLv2"

SLOT="0"

KEYWORDS="amd64 x86 arm arm64 mips"

DEPEND="sys-kernel/mkinitcpio-busybox
sys-apps/kmod
sys-apps/util-linux
app-arch/libarchive
sys-apps/coreutils
sys-apps/systemd
sys-apps/sed
sys-apps/findutils
virtual/awk
app-arch/zstd
"

RDEPEND="${DEPEND}"

BDEPEND="
app-arch/libarchive
app-text/asciidoc
sys-apps/sed
"
