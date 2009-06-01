# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

NEED_PYTHON="2.5"
EGIT_REPO_URI="git://github.com/phuang/${PN}.git"
inherit autotools git python

DESCRIPTION="Japanese input method Anthy IMEngine for IBus Framework"
HOMEPAGE="http://ibus.googlecode.com"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"

# autopoint needs cvs. Bug #152872
DEPEND="app-i18n/anthy
	dev-lang/swig
	dev-util/cvs
	dev-util/pkgconfig
	>=sys-devel/gettext-0.16.1"
RDEPEND=">=app-i18n/ibus-1.0
	app-i18n/anthy"

src_prepare() {
	autopoint || die "failed to run autopoint"
	eautoreconf
}

src_configure() {
	econf $(use_enable nls)
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	einfo
	ewarn "This package is very experimental, please report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	einfo
	elog "You should run ibus-setup and enable IMEngines you want to use."
	einfo

	# http://www.gentoo.org/proj/en/Python/developersguide.xml#doc_chap2
	python_mod_optimize && python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup && python_mod_cleanup /usr/share/${PN}
}
