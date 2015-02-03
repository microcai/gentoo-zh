# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Simple UEFI Boot Manager"
HOMEPAGE="http://freedesktop.org/wiki/Software/gummiboot"
EGIT_REPO_URI="git://anongit.freedesktop.org/gummiboot"
inherit toolchain-funcs autotools
#git-r3

SRC_URI="http://cgit.freedesktop.org/gummiboot/snapshot/${PN}-${PV}.tar.gz"
LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

COMMON_DEPEND="sys-apps/util-linux"

RDEPEND="${COMMON_DEPEND}"

DEPEND="${COMMON_DEPEND}
>=sys-boot/gnu-efi-3.0u"

pkg_setup(){
	local iarch
	case $ARCH in
		ia64)  iarch=ia64 ;;
		x86)   iarch=ia32 ;;
		amd64) iarch=x86_64 ;;
		*)     die "unknown architecture: $ARCH" ;;
	esac
}

src_prepare(){
	eautoreconf
}

pkg_postinst(){
	einfo	"To use ${PN}, excute"
	einfo 	"gummiboot --path \"path to ESP(Efi system partition)\" install "
}
