# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils multilib

DESCRIPTION="Chinese Open X Input Method Developed by Firefly "
HOMEPAGE="http://opendesktop.org.tw"
SRC_URI="ftp://ftp.opendesktop.org.tw/odp/others/OXIM/Source/tarball/${P}.tar.gz
	filters? ( ftp://ftp.opendesktop.org.tw/odp/others/OXIM/Source/tarball/oxim-filters.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="chewing eeepc +filters nls qt3 setup-tool"
RESTRICT="mirror"

#FIXME: libchewing[<0.3.0|>=0.3.0]
COMMON_DEP="chewing? ( >=dev-libs/libchewing-0.2.5 )
	qt3? ( x11-libs/qt:3 )
	>=x11-libs/gtk+-2.2.0
	x11-libs/libX11
	x11-libs/libXext
	>=x11-libs/libXft-2.0
	>=x11-libs/libXpm-2.0.0
	>=x11-libs/libXtst-1.0.0"
DEPEND="${COMMON_DEP}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	x11-proto/xproto"
RDEPEND="${COMMON_DEP}
	setup-tool? ( =app-i18n/oxim-setup-${PV} )"

pkg_setup() {
	# An arch specific config directory is used on multilib systems
	has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}
}

src_configure() {
	econf \
		--enable-gtk-immodule \
		--enable-unicode-module \
		$(use_enable chewing chewing-module) \
		$(use_enable eeepc EeePC) \
		$(use_enable nls) \
		$(use_enable qt3 qt-immodule)
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc ChangeLog AUTHORS NEWS README
	if use filters ; then
		cd "${WORKDIR}"/oxim-filters
		insinto /usr/lib/oxim/filters
		for filter in speak speed t2s-s2t unicode compose relate
		do
			einfo "install filter: $filter"
			doins $filter/oxim_*
		done
		dobin compose/zhocompose relate/zhorelate
	fi
}

pkg_postinst() {
	$(type -p gtk-query-immodules-2.0) > "${ROOT}"/${GTK2_CONFDIR}/gtk.immodules

	einfo
	einfo "Add below settings in your .xinitrc or .xsession :"
	einfo
	einfo "export LANG=your_locale (e.g. zh_CN.UTF-8 or zh_TW.UTF-8)"
	einfo "export XMODIFIERS=@im=oxim"
	einfo "export GTK_IM_MODULE=oxim"
	einfo "export QT_IM_MODULE=oxim"
	einfo "oxim &"
	einfo
}

pkg_postrm() {
	$(type -p gtk-query-immodules-2.0) > "${ROOT}"/${GTK2_CONFDIR}/gtk.immodules
}
