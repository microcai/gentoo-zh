# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://sunpinyin.org/"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS=""
RESTRICT="primaryuri"

SRC_URI="http://open-gram.googlecode.com/files/lm_sc.t3g.arpa-20120212.tar.bz2
	http://open-gram.googlecode.com/files/dict.utf8-20120824.tar.bz2"

RDEPEND=""
DEPEND="${RDEPEND}
	app-i18n/sunpinyin"

src_unpack() {
	default
	mkdir ${S}
	cp -s ${WORKDIR}/{lm_sc.t3g.arpa,dict.utf8} ${S} ||
		die 'cannot make links for dict files'
	bzcat /usr/share/doc/sunpinyin/SLM-inst.mk.bz2 > ${S}/Makefile ||
		die 'cannot find SLM-inst.mk'
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}

