# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit cvs qt3 eutils


ECVS_SERVER="opendesktop.org.tw:/misc/cvs"
ECVS_MODULE="oxim"
S="${WORKDIR}/${ECVS_MODULE}"

DESCRIPTION="Chinese Open X Input Method Developed by Firefly"
HOMEPAGE="http://opendesktop.org.tw/"

LICENSE="OXIM"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls gtk-im qt-im bimsphone chewing"

DEPEND="|| ( x11-libs/libXft virtual/x11 )
    dev-util/pkgconfig
    >=x11-libs/qt-3.3.4
    !app-i18n/oxim
    gtk-im? (>=x11-libs/gtk+-2)
    bimsphone? (>=app-i18n/libtabe-0.2.6)
    chewing? (>=dev-libs/libchewing-0.2.5)    
    nls? ( sys-devel/gettext )"


pkg_setup() {
	if use qt-im; then
		if [ ! -e /usr/qt/3/plugins/inputmethods/libqimsw-none.so ] ; then
			echo
			ewarn
			ewarn  "qt-im depends on libqimsw-none.so ."
			ewarn  "You need to re-emerge >=x11-libs/qt-3.3.4 with 'immqt-bc' USE flag ."
			ewarn  "Now, Oxim will continue to compile but without qt-im-module."
			ewarn
			echo
		fi
	fi  
	epause 3
}


src_unpack() {
	cvs_src_unpack
	cd ${S}
	sh autogen.sh || die "autogen failed"
	cd ${S}
	#epatch ${FILESDIR}/oxim-cvs-db3.patch 
	epatch ${FILESDIR}/qoximinputcontext_x11.diff 
}

src_compile() {

	if use gtk-im ; then
		myconf="${myconf} --enable-gtk-immodule=yes"
	else
		myconf="${myconf} --enable-gtk-immodule=no"
	fi
	if use qt-im ; then
		myconf="${myconf} --enable-qt-immodule=yes"
	else
		myconf="${myconf} --enable-qt-immodule=no"
	fi
	if use qt-im ; then
		myconf="${myconf} --enable-bimsphone-module=yes"
	else
		myconf="${myconf} --enable-bimsphone-module=no"
	fi
	if use chewing ; then
		myconf="${myconf} --enable-chewing-module=yes"
	else
		myconf="${myconf} --enable-chewing-module=no"
	fi
	econf \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-conf-dir=/etc/oxim \
		--with-tabe-data=/usr/share \
		--mandir=/usr/share/man \
		 ${myconf}|| die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog AUTHORS NEWS README 
}

pkg_postinst() {
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

