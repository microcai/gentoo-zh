# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
EGIT_REPO_URI="git://github.com/phuang/ibus-anthy.git"

inherit autotools eutils git

DESCRIPTION="Japanese input method Anthy IMEngine for IBus Input Framework"
HOMEPAGE="http://ibus.googlecode.com"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"

# Yeh, autopoint needs cvs, please have a look at Bug #152872
DEPEND="app-i18n/anthy
	dev-lang/python:2.5
	dev-lang/swig
	dev-util/cvs
	nls? ( sys-devel/gettext )"
RDEPEND="app-i18n/ibus
	app-i18n/anthy"

src_unpack() {
	git_src_unpack
	autopoint && eautoreconf
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
	ewarn "This package is very experimental, please report your bug here:"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog
	elog "To enable this input engine, you need to run ibus-setup"
	elog
}
