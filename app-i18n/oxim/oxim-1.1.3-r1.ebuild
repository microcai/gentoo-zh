# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="Chinese Open X Input Method Developed by Firefly "
HOMEPAGE="http://opendesktop.org.tw/"
SRC_URI="ftp://140.111.128.66/odp/OXIM/Source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86  amd64"
IUSE="nls gtk-im qt-im qt4 bimsphone chewing no-setup-tool"

DEPEND="|| ( x11-libs/libXft virtual/x11 )
    dev-util/pkgconfig
    !app-i18n/oxim-cvs
    gtk-im? ( >=x11-libs/gtk+-2 )
	qt-im? ( qt4? (x11-libs/qt ) 
			!qt4? ( <x11-libs/qt-4 ) )
	!no-setup-tool? ( qt4? ( x11-libs/qt ) 
			!qt4? ( <x11-libs/qt-4 ) )
    bimsphone? ( >=app-i18n/libtabe-0.2.6 )
    chewing? ( >=dev-libs/libchewing-0.2.5 )    
    nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
#	CFLAGS="$CFLAGS -I/usr/qt/3/mkspecs/linux-g++/"
#	export CFLAGS
	
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
	if use bimsphone ; then
		myconf="${myconf} --enable-bimsphone-module=yes"
	else
		myconf="${myconf} --enable-bimsphone-module=no"
	fi
	if use chewing ; then
		myconf="${myconf} --enable-chewing-module=yes"
	else
		myconf="${myconf} --enable-chewing-module=no"
	fi
	if use no-setup-tool ;  then
		myconf="${myconf} --enable-setup-tool=no"
	else
		myconf="${myconf} --enable-setup-tool=yes"
	fi

	econf \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-conf-dir=/etc/oxim \
		--with-tabe-data=/usr/share \
		--mandir=/usr/share/man \
		 ${myconf}|| die "econf failed"
	
	if use qt-im ; then
	 	cd ${S}/src/qt-immodule
		epatch ${FILESDIR}/qt-im-include-fix.patch
		cd -
	fi

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

