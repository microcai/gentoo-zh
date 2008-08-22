# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils

if [[ ${PV} == 9999 ]] ; then
	EGIT_REPO_URI="git://github.com/phuang/ibus-chewing.git"
	inherit git autotools
	EXTDEPEND="dev-util/cvs"
	src_unpack() {
		git_src_unpack
		autopoint && eautoreconf
	}
else
	SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"
fi

DESCRIPTION="The Chewing Engine for IBus Input Framework"
HOMEPAGE="http://ibus.googlecode.com"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

# Yeh, we really need cvs, please have a look at Bug #152872
DEPEND="${EXTDEPEND}
	dev-libs/libchewing
	dev-lang/python:2.5
	dev-lang/swig
	nls? ( sys-devel/gettext )"
RDEPEND="app-i18n/ibus"

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
