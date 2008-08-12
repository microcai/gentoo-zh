# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="git://github.com/phuang/ibus-anthy.git"
	inherit git
else
	SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"
fi

DESCRIPTION="The Anthy Engine for IBus Input Framework"
HOMEPAGE="http://ibus.googlecode.com"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86" # ~amd64
IUSE="nls"

DEPEND="app-i18n/anthy
	dev-lang/python:2.5
	dev-lang/swig
	nls? ( sys-devel/gettext )"
RDEPEND="app-i18n/ibus
	app-i18n/anthy"

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
	elog
	elog "To enable this input engine, you need to run ibus-setup"
	elog
}
