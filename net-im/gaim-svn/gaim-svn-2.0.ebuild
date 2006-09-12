# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $

inherit subversion flag-o-matic eutils toolchain-funcs debug multilib mono autotools perl-app

ESVN_REPO_URI="https://svn.sourceforge.net/svnroot/gaim/trunk"
ESVN_PROJECT="gaim"
ESVN_BOOTSTRAP="NOCONFIGURE=1 ./autogen.sh"

DESCRIPTION="GTK Instant Messenger client"
HOMEPAGE="http://gaim.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="avahi audiofile bonjour cjk dbus debug eds gadu gnutls meanwhile mono nas
nls perl silc spell startup-notification tcl tk xscreensaver custom-flags ssl
msn qq"

RDEPEND="
	audiofile? ( media-libs/libao
		media-libs/audiofile )
	bonjour? ( !avahi? ( net-misc/howl )
		   avahi? ( net-dns/avahi ) )
	dbus? ( >=sys-apps/dbus-0.35
		>=dev-lang/python-2.4 )
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	nas? ( >=media-libs/nas-1.4.1-r1 )
	perl? ( >=dev-lang/perl-5.8.2-r1 )
	spell? ( >=app-text/gtkspell-2.0.2 )
	gadu?  ( net-libs/libgadu )
	ssl? (
		gnutls? ( net-libs/gnutls )
		!gnutls? ( >=dev-libs/nss-3.11 )
	)
	msn? (
		gnutls? ( net-libs/gnutls )
		!gnutls? ( >=dev-libs/nss-3.11 )
	)
	meanwhile? ( net-libs/meanwhile )
	silc? ( >=net-im/silc-toolkit-0.9.12-r3 )
	eds? ( gnome-extra/evolution-data-server )
	tcl? ( dev-lang/tcl )
	tk? ( dev-lang/tk )
	startup-notification? ( >=x11-libs/startup-notification-0.5 )
	mono? ( dev-lang/mono )
	xscreensaver? ( x11-misc/xscreensaver
			x11-libs/libXScrnSaver )"

DEPEND="$RDEPEND
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"


pkg_setup() {
	if use avahi && ! built_with_use net-dns/avahi howl-compat ; then
	eerror
	eerror You need to rebuild net-dns/avavhi with USE=howl-compat in order
	eerror to enable howl support for the bonjour protocol in gaim.
	eerror
	die "Configure failed"
	fi

	if use gadu && built_with_use net-libs/libgadu ssl ; then
	eerror
	eerror You need to rebuild net-libs/libgadu with USE=-ssl in order
	eerror enable gadu gadu support in gaim.
	eerror
	die "Configure failed"
	fi
}

src_unpack() {
	subversion_src_unpack
}

src_compile() {
	# Stabilize things, for your own good
	if ! use custom-flags; then
		strip-flags
	fi
	replace-flags -O? -O2

	# -msse2 doesn't play nice on gcc 3.2
	[ "`gcc-version`" == "3.2" ] && filter-flags -msse2

	local myconf

	if ! use bonjour ; then
		myconf="${myconf} --with-howl-includes=."
		myconf="${myconf} --with-howl-libs=."
	fi

	if ! use silc; then
		einfo "Disabling SILC protocol"
		myconf="${myconf} --with-silc-includes=."
		myconf="${myconf} --with-silc-libs=."
	fi

	if ! use gadu ; then
		myconf="${myconf} --with-gadu-includes=."
		myconf="${myconf} --with-gadu-libs=."
	fi

	if use ssl || use msn ; then
		if use gnutls ; then
			einfo "Disabling NSS, using GnuTLS"
			myconf="${myconf} --enable-nss=no --enable-gnutls=yes"
			myconf="${myconf} --with-gnutls-includes=/usr/include/gnutls"
			myconf="${myconf} --with-gnutls-libs=/usr/$(get_libdir)"
		else
			einfo "Disabling GnuTLS, using NSS"
			myconf="${myconf} --enable-gnutls=no --enable-nss=yes"
		fi
	else
		einfo "No SSL support selected"
		myconf="${myconf} --enable-gnutls=no --enable-nss=no"
	fi

	if use xscreensaver ; then
			myconf="${myconf} --x-includes=/usr/include/X11"
	fi

	econf \
		$(use_enable nls) \
		$(use_enable perl) \
		$(use_enable spell gtkspell) \
		$(use_enable startup-notification) \
		$(use_enable tcl) \
		$(use_enable tk) \
		$(use_enable mono) \
		$(use_enable debug) \
		$(use_enable dbus) \
		$(use_enable meanwhile) \
		$(use_enable nas) \
		$(use_enable eds gevolution) \
		$(use_enable audiofile audio) \
		$(use_enable qq) \
		${myconf} || die "Configuration failed"

	emake -j1 || die "Make failed"
}

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	use perl && fixlocalpod
	dodoc ABOUT-NLS AUTHORS COPYING HACKING INSTALL NEWS PROGRAMMING_NOTES README ChangeLog VERSION
}
