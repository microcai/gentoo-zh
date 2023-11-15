# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="workaround to always show mouse cursor under x11"
HOMEPAGE="https://aur.archlinux.org/packages/extramaus"
SRC_URI="https://gist.githubusercontent.com/ibLeDy/aecab4b95b242ff07108c6d58e35d421/raw/44f2188279b4aec54f0d667bda72e542829c3240/extramaus.c"

inherit toolchain-funcs

SLOT="0"
KEYWORDS="~amd64"

DEPEND="x11-libs/libX11
x11-libs/libXext"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack(){
	cp ${DISTDIR}/extramaus.c $S/
}

src_compile(){
	CC=$(tc-getCC)
	$CC ${CFLAGS} ${LDFLAGS} extramaus.c -o extramaus -lX11 -lXext
}

src_install(){
	dobin extramaus
}
