# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Another Traditional Chinese IM."
HOMEPAGE="http://hyperrate.com/dir.php?eid=67"
SRC_URI="http://hyperrate.com/gcin-source/gcin-${PV}.tar.xz
	chinese-sound? ( http://ftp.twaren.net/local-distfiles/gcin/ogg.tgz )"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="filter-nobopomofo chinese-sound anthy chewing gtk3 qt4"

DEPEND=">=x11-libs/gtk+-2
	anthy? ( >=app-i18n/anthy-9100 )
	chewing? ( dev-libs/libchewing )
	gtk3? ( x11-libs/gtk+:3 )
	qt4? ( dev-qt/qtcore:4 dev-qt/qtgui )"
RDEPEND="${DEPEND}
	chinese-sound? ( media-sound/vorbis-tools[ogg123] )"
DEPEND="${DEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

RESTRICT="mirror"
S=${WORKDIR}/${P/_/.}

src_prepare() {
	echo "${P}" > ${S}/VERSION.gcin
	#epatch "${FILESDIR}/gcin-2.6.6_qtmoc_fix.patch"
}

src_configure() {
	econf --use_i18n=Y \
		--use_tsin=Y \
		--use_qt3=N \
		$(! use anthy && echo --use_anthy=N ) \
		$(! use chewing && echo --use_chewing=N ) \
		$(! use qt4 && echo --use_qt4=N ) \
		$(! use gtk3 && echo --use_gtk3=N )
}

src_compile() {
	filter-ldflags "-Wl,--as-needed"
	MAKEOPTS="${MAKEOPTS} -j1" emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use filter-nobopomofo ; then
		insinto /usr/share/pixmaps/gcin
		doins "${FILESDIR}"/nobopomofo/{SS1135_ST,SS1208_DT}.jpg || die
		exeinto /usr/share/gcin/script
		doexe "${FILESDIR}"/nobopomofo/gcin-filter-nobopomofo || die
		doenvd "${FILESDIR}"/nobopomofo/99gcin-filter-nobopomofo || die
	fi

	if use chinese-sound ; then
		insinto /usr/share/${PN}
		doins -r "${WORKDIR}"/ogg || die
	fi
}

update_gtk_immodules() {
	local GTK2_CONFDIR="/etc/gtk-2.0"
	# bug #366889
	if has_version '>=x11-libs/gtk+-2.22.1-r1:2' || has_multilib_profile ; then
		GTK2_CONFDIR="${GTK2_CONFDIR}/$(get_abi_CHOST)"
	fi
	mkdir -p "${EPREFIX}${GTK2_CONFDIR}"

	if [ -x "${EPREFIX}/usr/bin/gtk-query-immodules-2.0" ] ; then
		"${EPREFIX}/usr/bin/gtk-query-immodules-2.0" > "${EPREFIX}${GTK2_CONFDIR}/gtk.immodules"
	fi
}

pkg_postinst() {
	use gtk && update_gtk_immodules
	gnome2_icon_cache_update

}

pkg_postrm() {
	use gtk && update_gtk_immodules
	gnome2_icon_cache_update
}
