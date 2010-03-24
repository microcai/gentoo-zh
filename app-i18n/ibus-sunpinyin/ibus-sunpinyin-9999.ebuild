# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools python git

MY_PN="${PN##ibus-}"
EGIT_PROJECT="${MY_PN}"
EGIT_REPO_URI="git://github.com/sunpinyin/sunpinyin.git"
DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://sunpinyin.org/"
SRC_URI="
	https://open-gram.googlecode.com/files/dict.utf8.tar.bz2
	https://open-gram.googlecode.com/files/lm_sc.t3g.arpa.tar.bz2"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS=""
IUSE="debug"

RDEPEND="x11-libs/gtk+
	>=dev-libs/glib-2
	app-i18n/ibus
	!app-i18n/scim-sunpinyin
	>=dev-lang/python-2.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	ln -s "${DISTDIR}"/{dict.utf8,lm_sc.t3g.arpa}.tar.bz2 "${S}"/raw
	(./autogen.sh) || die "autogen.sh failed"
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf \
		$(use_enable debug) \
		--enable-ibus
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
