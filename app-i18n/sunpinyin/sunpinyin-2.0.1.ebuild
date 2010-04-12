# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit python versionator

EGIT_REPO_URI="git://github.com/sunpinyin/sunpinyin.git"

DESCRIPTION="SunPinyin is a SLM (Statistical Language Model) based IME"
HOMEPAGE="http://sunpinyin.org/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"
#	https://open-gram.googlecode.com/files/dict.utf8.tar.bz2
#	https://open-gram.googlecode.com/files/lm_sc.t3g.arpa.tar.bz2"

LICENSE="LGPL-2.1 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE_IM="ibus xim"
IUSE="debug nls ${IUSE_IM}"

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	dev-db/sqlite:3
	ibus? ( app-i18n/ibus )
	xim? ( x11-libs/libX11 )
	!app-i18n/ibus-sunpinyin
	!app-i18n/scim-sunpinyin
	>=dev-lang/python-2.5
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	xim? ( x11-proto/xproto )
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

pkg_setup() {
	for im in ${IUSE_IM}; do
		use ${im} && return;
	done
	eerror "You need to specify at least one input method to build."
	eerror "Valid input methods are: ${IUSE_IM}."
	die "No input methods were specified to build."
}

src_prepare() {
#	eautoreconf
#	ln -s "${DISTDIR}"/{dict.utf8,lm_sc.t3g.arpa}.tar.bz2 "${S}"/raw
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable nls) \
		$(use_enable ibus) \
		$(use_enable xim) || die
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	use ibus && python_mod_optimize /usr/share/ibus-${PN}/setup
}

pkg_postrm() {
	use ibus && python_mod_cleanup /usr/share/ibus-${PN}/setup
}
