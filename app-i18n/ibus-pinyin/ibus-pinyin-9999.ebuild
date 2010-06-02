# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="sqlite"

inherit python git autotools

EGIT_REPO_URI="git://github.com/phuang/ibus-pinyin.git"

PYDB_TAR="pinyin-database-1.2.99.tar.bz2"
DESCRIPTION="Chinese PinYin IMEngine for IBus Framework"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${PYDB_TAR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls +open-phrase"

RDEPEND=">=app-i18n/ibus-1.1.0
	>=dev-libs/boost-1.39
	sys-apps/util-linux
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( >=sys-devel/gettext-0.16.1 )"

src_prepare() {
	echo "AM_GNU_GETTEXT_VERSION(0.16.1)" >> "${S}"/configure.ac
	autopoint || die "failed to run autopoint"
	intltoolize --copy --force || die "intltoolize failed"
	eautoreconf

	cp "${DISTDIR}/${PYDB_TAR}" "${S}"/data/db/open-phrase/ || die
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf $(use_enable nls) $(use_enable open-phrase db-open-phrase) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bugs to"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog
	elog "You should run ibus-setup and enable IM Engines you want to use!"
	elog

	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
