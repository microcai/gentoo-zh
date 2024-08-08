# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Resource Compiler for ELF binaries"
HOMEPAGE="http://elfembed.sourceforge.net/index.php"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"

src_prepare(){
	default
	sed 's/gcc/\$\{CC\}/g' -i Makefile
}

src_compile(){
	emake OPT="${CFLAGS} ${LDFLAGS}" CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)"
}

src_install(){
	dodir /usr/bin
	install rc "${D}/usr/bin/rc"
	install re "${D}/usr/bin/re"
}
