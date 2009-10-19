# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="Chinese Open X Input Method Developed by Firefly "
HOMEPAGE="http://opendesktop.org.tw/"
SRC_URI="ftp://140.111.128.66/odp/OXIM/Source/${P}.tar.gz
filters? ( ftp://140.111.128.66/odp/OXIM/Source/oxim-filters.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="nls gtk-im qt-im chewing +filters"
RESTRICT="mirror"
DEPEND="|| ( x11-libs/libXft virtual/x11 )
    dev-util/pkgconfig
    !app-i18n/oxim-cvs
    gtk-im? ( >=x11-libs/gtk+-2 )
	qt-im? ( x11-libs/qt )
    chewing? ( >=dev-libs/libchewing-0.2.5 )    
    nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}
		setup-tool? ( =app-i18n/oxim-setup-${PV} )
		"
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
		--mandir=/usr/share/man \
		 ${myconf}|| die "econf failed"
	
	if use qt-im ; then
	 	cd ${S}/src/qt-immodule
		epatch ${FILESDIR}/qt-im-include-fix.patch
		cd -
	fi

	emake || {
				eerror "upgreade oxim error!"
				eerror "Please unemerge old oxim and emerge oxim again."
				eerror "If problem still occur, please contract to GOT Ebuild"
				die "make failed"
			}
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog AUTHORS NEWS README
	if use filters
	then
		cd ${WORKDIR}/oxim-filters
		for filter in speak speed t2s-s2t unicode compose relate
		do
			einfo "install filter: $filter"
			insinto /usr/lib/oxim/filters
			doins $filter/oxim_*
		done
		exeinto /usr/bin
		doexe compose/zhocompose
		doexe relate/zhorelate
	fi
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

