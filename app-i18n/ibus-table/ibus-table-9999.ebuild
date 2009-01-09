# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON="2.5"
EGIT_REPO_URI="git://github.com/acevery/${PN}.git"
inherit autotools git python

DESCRIPTION="General Table Engine for IBus Framework"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="minimal nls"

DEPEND="dev-util/cvs
	dev-util/pkgconfig
	sys-devel/gettext"
RDEPEND="app-i18n/ibus"

pkg_setup() {
	if ! python_mod_exists sqlite3 ; then
		eerror "We need sqlite module for python to generate table databases!"
		die "Please compile your python with \"sqlite\" USE flag!"
	fi
}

src_unpack() {
	git_src_unpack
	autopoint || die "failed to run autopoint"
	# econf/eautoreconf needs no die.
	eautoreconf

	# QA: disable pyc compiling
	mv py-compile py-compile.orgin
	ln -s $(type -P true) py-compile
}

src_compile() {
	econf $(use_enable !minimal additional) \
		$(use_enable nls)
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	einfo
	elog "You need to emerge specific IMEs to use IBus-Table."
	elog "such as ibus-table-zhengma, ibus-table-wubi,"
	elog "ibus-table-erbi, ibus-table-cangjie"
	einfo
	elog "Then, don't forget to run ibus-setup and enable the IM Engines you want to use!"
	einfo

	# http://www.gentoo.org/proj/en/Python/developersguide.xml#doc_chap2
	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
