# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

EGIT_REPO_URI="git://github.com/acevery/${PN}.git"
inherit autotools eutils git

DESCRIPTION="General Table Engine for IBus Framework"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+additional cangjie5 erbi-qs extra-phrases nls wubi zhengma"

# Autopoint needs cvs to work. Bug #152872
# NOTE(to myself):
# 1.autopoint is part of gettext, so we
#   don't need the conditional USE flag 'nls' *here*.
# 2.ibus seems to work without gettext (tested on my box).
# 3.extra-phrases is suggested by acevery (the upstream)?.
DEPEND="dev-util/cvs
	dev-util/pkgconfig
	>=dev-lang/python-2.5
	sys-devel/gettext"
RDEPEND="app-i18n/ibus
	>=dev-lang/python-2.5"

pkg_setup() {
	if ! built_with_use '>=dev-lang/python-2.5' sqlite; then
		eerror "You need build dev-lang/python with \"sqlite\" USE flag!"
		die "Please rebuild dev-lang/python with \"sqlite\" USE flag!"
	fi
}

src_unpack() {
	git_src_unpack
	autopoint || die "failed to run autopoint"
	eautoreconf
}

src_compile() {
	econf $(use_enable additional) \
		$(use_enable cangjie5) \
		$(use_enable erbi-qs) \
		$(use_enable extra-phrases) \
		$(use_enable nls) \
		$(use_enable wubi wubi86) \
		$(use_enable wubi wubi98) \
		$(use_enable zhengma)
	# Parallel make uses a lot of memory to generate databases.
	MAKEOPTS="-j1"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	echo
	elog "You should set USE flag properly before installing this package."
	elog "Don't forget to run ibus-setup and enable the IM Engines you want to use."
	echo
}
