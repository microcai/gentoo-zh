# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit autotools eutils git

EGIT_REPO_URI="git://github.com/phuang/ibus.git"
DESCRIPTION="Next Generation Input Bus for Linux"
HOMEPAGE="http://code.google.com/p/ibus"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+nls +immqt"

DEPEND="dev-lang/python:2.5
	dev-lang/swig
	dev-libs/dbus-glib
	>=dev-python/dbus-python-0.83.0
	immqt? (
			|| ( ( x11-libs/qt-gui x11-libs/qt-core )
			>=x11-libs/qt-4.3.2 )
	)
	dev-python/pyenchant
	dev-python/pygtk
	nls? ( sys-devel/gettext )"
#	x11-libs/qt-test
RDEPEND=">=dev-python/dbus-python-0.83.0
	dev-python/pygtk"

# based on ebuild in app-i18n/scim
get_gtk_confdir() {
	if use amd64 || ( [ "${CONF_LIBDIR}" == "lib32" ] && use x86 ) ;
	then
		echo "/etc/gtk-2.0/${CHOST}"
	else
		echo "/etc/gtk-2.0"
	fi
}

# upstream already fix it.
src_unpack() {
	git_src_unpack
	autopoint && eautoreconf
#	epatch "${FILESDIR}"/ibus-qmake-gentoo.patch
}

src_compile() {
	# no maintainer mode
	local myconf="--disable-option-checking \
		--enable--maintainer-mode \
		--disable-dependency-tracking \
		--disable-rpath"
	econf $myconf \
		$(use_enable nls) \
		$(use_enable immqt qt4-immodule) \
		|| die "config failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
}

pkg_postinst() {
	elog
	elog "To use ibus, you should set the following in your"
	elog "user startup scripts such as .xinitrc or .gnomerc"
	elog
	elog "export XMODIFIERS=\"@im=ibus\""
	elog "export GTK_IM_MODULES=\"ibus\""
	elog "export QT_IM_MODULES=\"ibus\""
	elog "ibus &"
	if ! use immqt; then
		ewarn "You might need immqt USE flag if you wanna"
		ewarn "ibus working in qt applications."
	fi
	elog
	einfo "Updating gtk.immodules"
	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > "${ROOT}$(get_gtk_confdir)/gtk.immodules"
}

pkg_postrm() {
	[ -x /usr/bin/gtk-query-immodules-2.0 ] && gtk-query-immodules-2.0 > "${ROOT}$(get_gtk_confdir)/gtk.immodules"
}
