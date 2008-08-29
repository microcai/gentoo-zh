# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils

DESCRIPTION="The Table Engine for IBus Input Framework"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"
HOMEPAGE="http://ibus.googlecode.com"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86" #~amd64
IUSE="nls zhengma wubi86 wubi98 cangjie5 erbi-qs +additional +extra-phrases"

# To run autopoint you need cvs.
RDEPEND="app-i18n/ibus
	dev-lang/python:2.5"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

pkg_setup() {
	if ! built_with_use 'dev-lang/python:2.5' sqlite; then
		eerror "You have to build dev-lang/python-2.5 with \"sqlite\" USE flag!"
		die "You have to build dev-lang/python-2.5 with \"sqlite\" USE flag!"
	fi
}

src_compile() {
	econf $(use_enable nls) \
		$(use_enable zhengma) \
		$(use_enable wubi86) \
		$(use_enable wubi98) \
		$(use_enable cangjie5) \
		$(use_enable erbi-qs) \
		$(use_enable extra-phrases) \
		$(use_enable additional) \
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
	elog
	elog "Don't forget to run ibus-setup and enable the IM Engine you need!"
	elog
}
