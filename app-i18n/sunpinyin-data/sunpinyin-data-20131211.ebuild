# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://sunpinyin.org/"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="primaryuri"

DICT_VERSION="${PV}"
LM_VERSION="20121025"
SRC_URI="https://open-gram.googlecode.com/files/dict.utf8-${DICT_VERSION}.tar.bz2
	https://open-gram.googlecode.com/files/lm_sc.t3g.arpa-${LM_VERSION}.tar.bz2"

RDEPEND=""
DEPEND="${RDEPEND}
	app-i18n/sunpinyin"

src_unpack() {
	default
	mkdir ${S}
	cp -s ${WORKDIR}/{lm_sc.t3g.arpa,dict.utf8} ${S} ||
		die 'cannot make links for dict files'
	cp ${FILESDIR}/SLM-inst.mk ${S}/Makefile ||
		die 'cannot find SLM-inst.mk'
}

src_configure() {
	if use alpha || use amd64 || use amd64-fbsd || use arm ||
		use hurd-i386 || use ia64 || use sh || use x86 || use x86-fbsd
	then
		endianness="le"
	elif use hppa || use m68k || use mips || use ppc ||
		use ppc64 || use s390 || use sparc || use sparc-fbsd
	then
		endianness="be"
	else
		die "cannot determine endianness of the platform"
	fi
}

src_compile() {
	emake ENDIANNESS=${endianness}
}

src_install() {
	emake ENDIANNESS=${endianness} DESTDIR="${D}" install
}
