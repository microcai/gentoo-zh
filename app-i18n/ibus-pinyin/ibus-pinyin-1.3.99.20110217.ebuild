# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus-pinyin/ibus-pinyin-1.3.99.20101029.ebuild,v 1.1 2010/11/05 14:28:59 matsuu Exp $

EAPI="2"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="sqlite"
inherit python

PYDB_TAR="pinyin-database-1.2.99.tar.bz2"
DESCRIPTION="Chinese PinYin IMEngine for IBus Framework"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz
	http://ibus.googlecode.com/files/${PYDB_TAR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls opencc +boost"

RDEPEND=">=app-i18n/ibus-1.3
	boost? ( >=dev-libs/boost-1.39 )
	opencc? ( >=app-i18n/opencc-0.1.2 )
	sys-apps/util-linux
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( >=sys-devel/gettext-0.16.1 )"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	cp "${DISTDIR}/${PYDB_TAR}" "${S}"/data/db/open-phrase/ || die
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf $(use_enable nls) $(use_enable boost) $(use_enable opencc) --enable-db-open-phrase || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README || die
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}
	
	use boost || elog "You have disable boost use flag, do not report bug as that's not supported"
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
