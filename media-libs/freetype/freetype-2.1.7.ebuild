# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic

SPV="`echo ${PV} | cut -d. -f1,2`"

DESCRIPTION="A high-quality and portable font engine"
HOMEPAGE="http://www.freetype.org/"
SRC_URI="mirror://sourceforge/freetype/${P/_/}.tar.bz2
	doc? ( mirror://sourceforge/${PN}/ftdocs-${PV}.tar.bz2 )"

SLOT="2"
LICENSE="FTL GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~ia64 ~amd64 ~ppc64"
IUSE="zlib bindist cjk doc"

DEPEND="virtual/libc
	zlib? ( sys-libs/zlib )"

src_unpack() {

	unpack ${A}

	cd ${S}
	# begin firefly patches
	# add autohint patch from http://www.kde.gr.jp/~akito/patch/freetype2/2.1.5/
#	use cjk && epatch ${FILESDIR}/${SPV}/${P}-autohint-cjkfonts-20031130.patch
	epatch ${FILESDIR}/${SPV}/freetype-2.1.6-enable_bytecode.patch
	epatch ${FILESDIR}/${SPV}/freetype-2.1.7-autohint-cjkfonts-20031121.patch
	# end firefly patches
}

src_compile() {

	use bindist || append-flags "${CFLAGS} -DTT_CONFIG_OPTION_BYTECODE_INTERPRETER"

	make setup CFG="--host=${CHOST} --prefix=/usr `use_with zlib`" unix || die

	emake || die

	# Just a check to see if the Bytecode Interpreter was enabled ...
	if [ -z "`grep TT_Goto_CodeRange ${S}/objs/.libs/libfreetype.so`" ]
	then
		ewarn "Bytecode Interpreter is disabled."
	fi

}

src_install() {

	make prefix=${D}/usr install || die

	dodoc ChangeLog README
	dodoc docs/{CHANGES,CUSTOMIZE,DEBUG,*.txt,PATENTS,TODO}

	use doc && dohtml -r docs/*

}
