# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
EGIT_REPO_URI="git://github.com/acevery/ibus-table.git"

inherit autotools eutils git

DESCRIPTION="The Table Engine for IBus Input Framework"
HOMEPAGE="http://ibus.googlecode.com"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="" #~x86 ~amd64
IUSE="nls zhengma wubi cangjie5 erbi-qs +additional extra-phrases"

# To run autopoint you need cvs.
RDEPEND="app-i18n/ibus
	dev-lang/python:2.5"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/cvs"

pkg_setup() {
	if ! built_with_use 'dev-lang/python:2.5' sqlite; then
		eerror "You need build dev-lang/python-2.5 with \"sqlite\" USE flag!"
		die "You need build dev-lang/python-2.5 with \"sqlite\" USE flag!"
	fi
}

src_unpack() {
	git_src_unpack
	autopoint || die "failed to run autopoint"
	eautoreconf
}

src_compile() {
	econf $(use_enable nls) \
		$(use_enable zhengma) \
		$(use_enable wubi wubi86) \
		$(use_enable wubi wubi98) \
		$(use_enable cangjie5) \
		$(use_enable erbi-qs) \
		$(use_enable extra-phrases) \
		$(use_enable additional)
	# Parallel make uses a lot of memory to generate databases.
	emake -j1 || die
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bug here:"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog
	elog "Don't forget to run ibus-setup and enable the IM Engine you want to use!"
	elog
}
