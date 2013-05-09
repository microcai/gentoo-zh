# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Simple UEFI Boot Manager"
HOMEPAGE="http://freedesktop.org/wiki/Software/gummiboot"
EGIT_REPO_URI="git://anongit.freedesktop.org/gummiboot"
inherit toolchain-funcs autotools git-2

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""


RDEPEND=">=sys-boot/gnu-efi-3.0s"

DEPEND=">=sys-boot/gnu-efi-3.0s"

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

src_compile(){
	make || \
		ld -T /usr/lib64/elf_x86_64_efi.lds -shared -Bsymbolic \
		-nostdlib -znocombreloc -L /usr/lib64 /usr/lib64/crt0-efi-x86_64.o \
		./src/efi/gummiboot.o -o src/efi/gummiboot.so -lefi -lgnuefi \
		/usr/lib/gcc/x86_64-pc-linux-gnu/4.8.0/libgcc.a
	MAKEOPTS=-j1 emake -j1
}

pkg_postinst(){
	einfo	"To use ${PN}, excute"
	einfo 	"gummiboot --path \"path to ESP(Efi system partition)\" install "
}
