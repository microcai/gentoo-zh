# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

HOMEPAGE="https://fcitx.googlecode.com"
DESCRIPTION="Free Chinese Input Toy of X - Input Method Server for X window system"
LICENSE="GPL-2"
SLOT="0"

IUSE="+cairo debug +gtk +gtk3 introspection lua opencc +pango qt4 snooper static-libs table test"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://github.com/fcitx/fcitx.git"
	FCITX_SRC_URI="${HOMEPAGE}/files/pinyin.tar.gz
		table? ( ${HOMEPAGE}/files/table.tar.gz )"
	FCITX_ECLASS="git-2"
	KEYWORDS=""
else
	FCITX_SRC_URI="https://github.com/fcitx/fcitx/tarball/${PV} -> ${P}.tar.gz
		${HOMEPAGE}/files/pinyin.tar.gz
		table? ( ${HOMEPAGE}/files/table.tar.gz )"
	RESTRICT="mirror"
	FCITX_ECLASS="vcs-snapshot"
	KEYWORDS="~amd64 ~x86"
fi

inherit cmake-utils ${FCITX_ECLASS}

SRC_URI="${FCITX_SRC_URI}"

RDEPEND="cairo? ( x11-libs/cairo[X]
		pango? ( x11-libs/pango[X] )
		!pango? ( media-libs/fontconfig ) )
	sys-apps/dbus
	gtk3? ( x11-libs/gtk+:3
		dev-libs/glib:2
		dev-libs/dbus-glib )
	gtk? ( x11-libs/gtk+:2
		dev-libs/glib:2
		dev-libs/dbus-glib )
	introspection? ( dev-libs/gobject-introspection )
	opencc? ( app-i18n/opencc )
	qt4? ( x11-libs/qt-gui:4
		x11-libs/qt-dbus:4 )
	lua? ( dev-lang/lua )
	x11-libs/libX11"
DEPEND="${RDEPEND}
	app-arch/tar
	app-arch/xz-utils
	app-text/iso-codes
	app-text/enchant
	dev-libs/icu
	dev-util/intltool
	app-arch/xz-utils
	x11-libs/libxkbfile"

update_gtk_immodules() {
	local GTK2_CONFDIR="/etc/gtk-2.0"
	# bug #366889
	if has_version '>=x11-libs/gtk+-2.22.1-r1:2' || has_multilib_profile; then
		GTK2_CONFDIR="${GTK2_CONFDIR}/$(get_abi_CHOST)"
	fi
	mkdir -p "${EPREFIX}${GTK2_CONFDIR}"
	if [ -x "${EPREFIX}/usr/bin/gtk-query-immodules-2.0" ]; then
		"${EPREFIX}/usr/bin/gtk-query-immodules-2.0" > \
		"${EPREFIX}${GTK2_CONFDIR}/gtk.immodules"
	fi
}

update_gtk3_immodules() {
	if [ -x "${EPREFIX}/usr/bin/gtk-query-immodules-3.0" ]; then
		"${EPREFIX}/usr/bin/gtk-query-immodules-3.0" --update-cache
	fi
}

src_unpack() {
	${FCITX_ECLASS}_src_unpack
}

src_prepare() {
	cp ${DISTDIR}/pinyin.tar.gz ${S}/data || die
	if use table; then
		cp ${DISTDIR}/table.tar.gz ${S}/data/table || die
	fi
}

src_configure() {
	local mycmakeargs=(
			$(cmake-utils_use_enable cairo CAIRO ) \
			$(cmake-utils_use_enable debug DEBUG ) \
			$(cmake-utils_use_enable gtk GTK2_IM_MODULE ) \
			$(cmake-utils_use_enable gtk3 GTK3_IM_MODULE ) \
			$(cmake-utils_use_enable introspection GIR ) \
			$(cmake-utils_use_enable lua LUA ) \
			$(cmake-utils_use_enable opencc OPENCC ) \
			$(cmake-utils_use_enable pango PANGO ) \
			$(cmake-utils_use_enable qt4 QT_IM_MODULE ) \
			$(cmake-utils_use_enable static-libs STATIC ) \
			$(cmake-utils_use_enable snooper SNOOPER ) \
			$(cmake-utils_use_enable table TABLE ) \
			$(cmake-utils_use_enable test TEST )
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dodir /etc/X11/xinit/xinitrc.d/

	XINITRCFCITX="${D}/etc/X11/xinit/xinitrc.d/01-input"

	# fix firefox issue
	echo "#! /bin/bash"  > "${XINITRCFCITX}"

	# echo XIM 
	echo "export XMODIFIERS=\"@im=fcitx\""  >> "${XINITRCFCITX}"
	echo "export XIM=fcitx" >> "${XINITRCFCITX}"
	echo "export XIM_PROGRAM=fcitx" >> "${XINITRCFCITX}"

	#echo gtk module
	if use gtk || use gtk3 ; then
		echo "export GTK_IM_MODULE=fcitx" >> "${XINITRCFCITX}"
	fi
	if use qt4 ; then
		echo "export QT_IM_MODULE=fcitx" >> "${XINITRCFCITX}"
	fi
	chmod 0755 "${XINITRCFCITX}"
}

pkg_postinst() {
	use gtk3 && update_gtk3_immodules
	use gtk && update_gtk_immodules
}

pkg_postrm() {
	use gtk3 && update_gtk3_immodules
	use gtk && update_gtk_immodules
}

