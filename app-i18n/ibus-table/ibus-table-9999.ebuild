# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils

if [[ ${PV} == 9999 ]] ; then
	EGIT_BRANCH="add_tables"
	EGIT_REPO_URI="git://github.com/phuang/${PN}.git"
	inherit git autotools
	EXTDEPEND="dev-util/cvs"
	src_unpack() {
		git_src_unpack
		autopoint && eautoreconf
	}
else
	SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"
fi

DESCRIPTION="Table based ImEngine Framework for IBus Platform"
HOMEPAGE="http://ibus.googlecode.com"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="" #~x86 ~amd64
IUSE="nls"

# Yeh, we really need cvs, please have a look at Bug #152872
DEPEND="${EXTDEPEND}
	dev-lang/python:2.5
	nls? ( sys-devel/gettext )"
RDEPEND="app-i18n/ibus"

src_compile() {
	econf $(use_enable nls) \
		--enable-maintainer-mode \
		--disable-option-checking \
		--disable-rpath \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bug here:"
	ewarn "http://ibus.googlecode.com/issues/list"
}
