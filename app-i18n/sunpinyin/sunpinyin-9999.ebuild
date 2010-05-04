# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
PYTHON_DEPEND="ibus? 2:2.5"
inherit autotools confutils eutils git python

EGIT_REPO_URI="git://github.com/sunpinyin/sunpinyin.git"

DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://sunpinyin.org/"
SRC_URI="https://open-gram.googlecode.com/files/dict.utf8.tar.bz2
	https://open-gram.googlecode.com/files/lm_sc.t3g.arpa.tar.bz2"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS=""
IUSE="debug ibus nls +xim"

RDEPEND="dev-db/sqlite:3
	ibus? (
		>=app-i18n/ibus-1.1
		!app-i18n/ibus-sunpinyin
	)
	nls? ( virtual/libintl )
	xim? (
		>=x11-libs/gtk+-2.12:2
		x11-libs/libX11
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	xim? ( x11-proto/xproto )"

RESTRICT="mirror"

pkg_setup() {
	confutils_require_any uim xim
}

src_prepare() {
	epatch "${FILESDIR}/${P}-mkdir.patch"
	eautoreconf
	ln -s "${DISTDIR}"/{dict.utf8,lm_sc.t3g.arpa}.tar.bz2 "${S}"/raw
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable ibus) \
		$(use_enable nls) \
		$(use_enable xim) || die
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO || die
}

pkg_postinst() {
	use ibus && python_mod_optimize /usr/share/ibus-${PN}/setup
	if use xim ; then
		elog "To use sunpinyin with XIM, you should use the following"
		elog "in your user startup scripts such as .xinitrc or .xprofile:"
		elog "XMODIFIERS=@im=xsunpinyin ; export XMODIFIERS"
	fi
}

pkg_postrm() {
	use ibus && python_mod_cleanup /usr/share/ibus-${PN}/setup
}
