# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON="2.5"
inherit python

DESCRIPTION="Chinese Chewing Engine for IBus Framework"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

# Autopoint needs cvs, Bug #152872
COMMON_DEPEND="dev-libs/libchewing"
DEPEND="${COMMON_DEPEND}
	dev-lang/swig
	nls? ( sys-devel/gettext )"
RDEPEND="${COMMON_DEPEND}
	app-i18n/ibus"

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
	elog "You should run ibus-setup and enable IMEngines you want to use."
}
