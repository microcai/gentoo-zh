# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit autotools eutils git

EGIT_REPO_URI="git://github.com/phuang/ibus-pinyin.git"
PYDB_VER="0.1.10.5"
DESCRIPTION="The PinYin Engine for IBus"
HOMEPAGE="http://code.google.com/p/ibus"
SRC_URI="http://scim-python.googlecode.com/files/pinyin-database-${PYDB_VER}.tar.bz2"

RESTRICT="mirror"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+nls"

DEPEND="dev-lang/python:2.5
	dev-python/pygtk
	dev-perl/XML-Parser
	nls? ( sys-devel/gettext )"
RDEPEND="app-i18n/ibus
	dev-python/pygtk"

src_unpack() {
	git_src_unpack
	autopoint && eautoreconf
	cp "${DISTDIR}"/pinyin-database-${PYDB_VER}.tar.bz2 engine
}

src_compile() {
	econf $(use_enable nls) \
		--disable-option-checking \
		--disable-rpath
		emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	#dodoc AUTHORS COPYING ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is highly experimental. Dont't blame me"
	ewarn "If it won't work. ;-) "
}
