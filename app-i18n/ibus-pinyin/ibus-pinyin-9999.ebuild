# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
EGIT_REPO_URI="git://github.com/phuang/ibus-pinyin.git"
PYDBTAR="pinyin-database-0.1.10.5.tar.bz2"

inherit eutils autotools git

DESCRIPTION="The PinYin Engine for IBus Input Framework"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI="http://scim-python.googlecode.com/files/${PYDBTAR}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"

# To run autopoint you need cvs.
DEPEND="nls? ( sys-devel/gettext )
	dev-util/cvs"
RDEPEND="app-i18n/ibus"

pkg_setup() {
	if ! built_with_use 'dev-lang/python:2.5' sqlite; then
		ewarn "To use ibus-pinyin you need build dev-lang/python with \"sqlite\" USE flag"
		die "To use ibus-pinyin you need build dev-lang/python against sqlit"
	fi
}

src_unpack() {
	git_src_unpack
	autopoint && eautoreconf
	cp "${DISTDIR}/${PYDBTAR}" engine
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
