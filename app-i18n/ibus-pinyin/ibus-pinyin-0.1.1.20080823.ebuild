# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
PYDBTAR="pinyin-database-0.1.10.5.tar.bz2"

inherit eutils

DESCRIPTION="The PinYin Engine for IBus Input Framework"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz
	http://scim-python.googlecode.com/files/${PYDBTAR}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND="app-i18n/ibus"

pkg_setup() {
	if ! built_with_use 'dev-lang/python:2.5' sqlite; then
		ewarn "To use ibus-pinyin you need build dev-lang/python with \"sqlite\" USE flag"
		die "To use ibus-pyinyin you have to build python against sqlite"
	fi
}

src_unpack() {
	unpack ${P}.tar.gz
	cp "${DISTDIR}/${PYDBTAR}" "${S}"/engine
}

src_compile() {
	econf $(use_enable nls) \
		--disable-option-checking \
		--disable-rpath
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This is a highly experimental package, please report your bug here:"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog
	elog "To enable this engine you need to run ibus-setup."
	elog
}
