# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
EGIT_REPO_URI="git://github.com/phuang/ibus-anthy.git"

inherit autotools git

DESCRIPTION="Japanese input method Anthy IMEngine for IBus Framework"
HOMEPAGE="http://ibus.googlecode.com"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"

# autopoint needs cvs. Bug #152872
DEPEND="app-i18n/anthy
	>=dev-lang/python-2.5
	dev-lang/swig
	sys-devel/gettext
	dev-util/cvs"
RDEPEND="app-i18n/ibus
	app-i18n/anthy
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
	ewarn "This package is very experimental, please report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog "You should run ibus-setup and enable IM Engines you want to use."
}
