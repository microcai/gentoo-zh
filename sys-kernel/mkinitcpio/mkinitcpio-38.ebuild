# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Modular initramfs image creation utility"
HOMEPAGE="https://github.com/archlinux/mkinitcpio"

SRC_URI="https://github.com/archlinux/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="amd64 arm arm64 mips x86"

IUSE="+systemd"

DEPEND="sys-apps/kmod
sys-apps/util-linux
app-arch/libarchive
app-arch/zstd
sys-apps/busybox
sys-apps/coreutils
sys-apps/findutils
sys-apps/sed
app-alternatives/awk
sys-apps/baselayout[-split-usr]
"

RDEPEND="${DEPEND}
	systemd? ( sys-apps/systemd[-split-usr] )
"

BDEPEND="
sys-apps/busybox
app-arch/libarchive
app-text/asciidoc
sys-apps/sed
"

src_install(){
	default_src_install
	exeinto /usr/lib/initcpio/
	doexe /bin/busybox
	insinto /usr/lib/initcpio/install
	newins "${FILESDIR}"/initcpio-install-systemd systemd
	newins "${FILESDIR}"/initcpio-install-base base
	insinto /usr/lib/initcpio/hooks
	newins "${FILESDIR}"/initcpio-hook-udev udev
	insinto /etc/mkinitcpio.d
	doins "${FILESDIR}"/linux.preset
}
