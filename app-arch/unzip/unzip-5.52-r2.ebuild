# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unzip/unzip-5.52-r1.ebuild,v 1.21 2008/02/08 15:09:57 cla Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="unzipper for pkzip-compressed files"
HOMEPAGE="http://www.info-zip.org/"
SRC_URI="mirror://gentoo/${PN}${PV/.}.tar.gz"

LICENSE="Info-ZIP"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="linguas_zh"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-no-exec-stack.patch
	sed -i \
		-e 's:-O3:$(CFLAGS) $(CPPFLAGS):' \
		-e 's:-O :$(CFLAGS) $(CPPFLAGS) :' \
		-e "s:CC=gcc :CC=$(tc-getCC) :" \
		-e "s:LD=gcc :LD=$(tc-getCC) :" \
		-e 's:LF2 = -s:LF2 = :' \
		-e 's:LF = :LF = $(LDFLAGS) :' \
		-e 's:SL = :SL = $(LDFLAGS) :' \
		-e 's:FL = :FL = $(LDFLAGS) :' \
		unix/Makefile \
		|| die "sed unix/Makefile failed"
}

src_compile() {
	local TARGET
	case ${CHOST} in
		i?86*-linux*) TARGET=linux_asm ;;
		*-linux*)     TARGET=linux_noasm ;;
		i?86*-freebsd* | i?86*-dragonfly* | i?86*-openbsd* | i?86*-netbsd*)
		              TARGET=freebsd ;; # mislabelled bsd with x86 asm
		*-freebsd* | *-dragonfly* | *-openbsd* | *-netbsd*)
		              TARGET=bsd ;;
		*-darwin*)    TARGET=macosx ;;
		*)            die "Unknown target, you suck" ;;
	esac
	append-lfs-flags #104315
	use linguas_zh && append-flags \
		"-D 'Ext_ASCII_TO_Native(str, n, v, x, l)=_ISO_INTERN(str)'"
	emake -f unix/Makefile ${TARGET} || die "emake failed"
}

src_install() {
	dobin unzip funzip unzipsfx unix/zipgrep || die "dobin failed"
	dosym unzip /usr/bin/zipinfo
	doman man/*.1
	dodoc BUGS History* README ToDo WHERE
}

pkg_postinst() {
	elog "If you receive a zip file from a Windows user, after unzip the file"
	elog "you find Chinese chars in the filename are garbled and you can't"
	elog "recover it no matter how you convert them, you should try add"
	elog "LINGAUS=zh to your make.conf and re-emerge unzip, and unzip it again."
	elog ""
	elog "Note: even after this, maybe you still couldn't see the right chars."
	elog "This time convmv can save you. All you need to know is which language"
	elog "version of Windows that Windows user is using and which encodin you"
	elog "are using."
	elog ""
	elog "Note again: this trick may apply to Korean and Japanese users too."
	elog "But I do not have the condition to test it -- r0bertz"
}

