# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools git python

EGIT_PROJECT="${PN##ibus-}"
EGIT_REPO_URI="git://github.com/sunpinyin/sunpinyin.git"

DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://sunpinyin.org/"
SRC_URI="
	https://open-gram.googlecode.com/files/dict.utf8.tar.bz2
	https://open-gram.googlecode.com/files/lm_sc.t3g.arpa.tar.bz2"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS=""
IUSE="debug nls"

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	dev-db/sqlite:3
	app-i18n/ibus
	!app-i18n/scim-sunpinyin
	>=dev-lang/python-2.5
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	eautoreconf
	ln -s "${DISTDIR}"/{dict.utf8,lm_sc.t3g.arpa}.tar.bz2 "${S}"/raw
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable nls) \
		--enable-ibus || die
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}/setup
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}/setup
}
