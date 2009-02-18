# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://github.com/acevery/${PN}.git"
inherit autotools git python

DESCRIPTION="General table engines for IBus Framework"
HOMEPAGE="http://ibus.googlecode.com"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="minimal nls"

RDEPEND=">=app-i18n/ibus-1.1
	>=dev-lang/python-2.5[sqlite]"
DEPEND="${RDEPEND}
	dev-util/cvs
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	autopoint || die "failed to run autopoint"
	eautoreconf

	# QA: disable pyc compiling
	mv py-compile py-compile.orgin
	ln -s $(type -P true) py-compile
}

src_configure() {
	econf $(use_enable !minimal additional) \
		$(use_enable nls)
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS README

	rm "${D}"//usr/share/ibus-table/engine/speedmeter.py || die
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
