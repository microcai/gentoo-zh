# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit git autotools

EGIT_REPO_URI="git://github.com/phuang/ibus-hangul.git"

DESCRIPTION="Korean input method Hangul IMEngine for IBus Framework"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"

# autopoint need cvs to work. Bug #152872
DEPEND="app-i18n/libhangul
	>=dev-lang/python-2.5
	dev-lang/swig
	dev-util/cvs
	sys-devel/gettext"
RDEPEND="app-i18n/ibus
	app-i18n/libhangul
	>=dev-lang/python-2.5"

src_unpack() {
	git_src_unpack
	autopoint || die "failed to run autopoint"
	eautoreconf
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
	ewarn "This package is very experimental, please report your bugs to:"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog "You should run ibus-setup and enable IMEngines you want to use."
}
