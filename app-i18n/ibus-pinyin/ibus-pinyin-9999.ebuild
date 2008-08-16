# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils

PYDB_VER="0.1.10.5"
if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="git://github.com/phuang/ibus-pinyin.git"
	inherit autotools git
	SRC_URI="http://scim-python.googlecode.com/files/pinyin-database-${PYDB_VER}.tar.bz2"
else
	SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz
		http://scim-python.googlecode.com/files/pinyin-database-${PYDB_VER}.tar.bz2"
fi

DESCRIPTION="The PinYin Engine for IBus Input Framework"
HOMEPAGE="http://ibus.googlecode.com"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="" #~x86 ~amd64
IUSE="nls"

# To run autopoint you need cvs.
DEPEND="nls? ( sys-devel/gettext )
	dev-util/cvs"
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
	#dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bug here:"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog
	elog "Please run ibus-setup and choose pinyin as the"
	elog "default input engine"
	elog
}
