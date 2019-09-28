# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MODULES_OPTIONAL_USE="modules"
MODULES_OPTIONAL_USE_IUSE_DEFAULT=0

inherit linux-mod

DESCRIPTION="Fast File Search Tool for DDE"
HOMEPAGE="https://github.com/linuxdeepin/deepin-anything"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/glibc
	dde-base/dtkcore
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dde-base/udisks2-qt5
		"

BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="vfs_monitor(misc:${S}/kernelmod)"

pkg_setup() {
	CONFIG_CHECK="~KPROBES"
	use modules && linux-mod_pkg_setup
	BUILD_PARAMS="CC=$(tc-getBUILD_CC) KERN_DIR=${KV_DIR} KERN_VER=${KV_FULL} O=${KV_OUT_DIR} V=1 KBUILD_VERBOSE=0"
}

src_prepare() {
	LIBDIR=$(get_libdir)
	sed -i "s|/usr/lib/|/usr/${LIBDIR}/|g" Makefile
	sed -i "s|^DEB_HOST_MULTIARCH.*||g" Makefile

	default_src_prepare
}

src_compile() {
	emake VERSION=${PV}

	use modules && linux-mod_src_compile

}

src_install() {
	emake VERSION=${PV} DESTDIR="${D}" install
	use modules && linux-mod_src_install
	rm -r ${D}/usr/src
}
