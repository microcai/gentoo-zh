# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="Data sets for Sunpinyin"
HOMEPAGE="https://code.google.com/p/open-gram/"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="primaryuri"

DICT_VERSION="20131214"
LM_VERSION="${PV}"
SRC_URI="
	mirror://sourceforge/open-gram/dict.utf8-${DICT_VERSION}.tar.bz2
	mirror://sourceforge/open-gram/lm_sc.3gm.arpa-${LM_VERSION}.tar.bz2"

RDEPEND=""
DEPEND="${RDEPEND}
	app-i18n/sunpinyin"

pkg_setup() {
	[[ -x ${EROOT}/usr/bin/slmpack ]] ||
		die 'slmpack(1) not found, please rebuild app-i18n/sunpinyin-9999'
}

src_unpack() {
	default
	mkdir "${S}" || die "cannot mkdir ${S}"
	mv "${WORKDIR}"/{lm_sc.3gm.arpa,dict.utf8} "${S}" ||
		die 'cannot move dict files'
	cp "${FILESDIR}"/SLM-inst.mk "${S}"/Makefile ||
		die 'cannot copy SLM-inst.mk'
}

src_configure() {
	case "$(tc-endian)" in
		'little') endianness='le';;
		'big') endianness='be';;
		*) die 'cannot determine endianness of the platform';;
	esac
}

src_compile() {
	emake ENDIANNESS="${endianness}"
}

src_install() {
	emake ENDIANNESS="${endianness}" DESTDIR="${D}" install
}
