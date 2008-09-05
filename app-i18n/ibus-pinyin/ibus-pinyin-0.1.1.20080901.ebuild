# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

PYDB_TAR="pinyin-database-0.1.10.5.tar.bz2"
DESCRIPTION="Chinese PinYin IMEngine for IBus Framework"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz
	http://scim-python.googlecode.com/files/${PYDB_TAR}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"

DEPEND=">=dev-lang/python-2.5
	nls? ( sys-devel/gettext )"
RDEPEND="app-i18n/ibus
	>=dev-lang/python-2.5"

pkg_setup() {
	if ! built_with_use '>=dev-lang/python-2.5' sqlite; then
		eerror "To use ibus-pinyin you have to build dev-lang/python with \"sqlite\" USE flag!"
		die "To use ibus-pinyin you have to build dev-lang/python with \"sqlite\" USE flag!"
	fi
}

src_unpack() {
	unpack ${P}.tar.gz
	cp "${DISTDIR}/${PYDB_TAR}" "${S}"/engine
}

src_compile() {
	econf $(use_enable nls) \
		--enable-maintainer-mode \
		--disable-option-checking \
		--disable-rpath
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog "You should run ibus-setup and enable IM Engines you want to use."
}
