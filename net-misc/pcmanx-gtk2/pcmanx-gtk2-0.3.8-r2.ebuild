# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic eutils autotools multilib

DESCRIPTION="PCMan is an easy-to-use telnet client mainly targets BBS users formerly writen by gtk2"
SRC_URI="http://pcmanx.csie.net/release/${P}.tar.bz2"
HOMEPAGE="http://pcmanx.csie.net/"
RESTRICT="nomirror"

KEYWORDS="x86 ~ppc amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="firefox libnotify socks5"

DEPEND=">=x11-libs/gtk+-2.4
	x11-libs/libXft
	dev-util/intltool
	net-misc/wget
	firefox? ( >=www-client/mozilla-firefox-3.0 )
	libnotify? ( x11-libs/libnotify )
	!www-client/pcmanxplug-in
	!virtual/pcmanx"

PROVIDE="virtual/pcmanx"

src_unpack()
{
	unpack ${A}
	cd ${S}
	(has_version ">=net-libs/xulrunner-1.9" && use firefox ) &&\
		epatch "${FILESDIR}/${P}-xulrunner.patch"	
	eautoreconf
}

src_compile() {
	# this flag crashes CTermData::memset16()
	filter-flags -ftree-vectorize

	local myconf="$(use_enable firefox plugin) \
				  $(use_enable socks5 proxy) \
				  $(use_enable libnotify) \
				  --enable-wget"
	econf $myconf || die "econf failed"
	emake || die "emake failed"
}

src_install()
{
	cd ${S}
	emake DESTDIR="${D}" install || die "emake failed"

	exeinto /usr/$(get_libdir)/nsbrowser/plugins
	doexe plugin/src/pcmanx-plugin.so
	insinto /usr/$(get_libdir)/nsbrowser/plugins
	doins plugin/src/pcmanx-plugin.so
}
resetplugin()
{
	use firefox && /usr/lib/xulrunner/regxpcom
}

pkg_postinst()
{
	resetplugin
	if use firefox
	then
		web=firefox

		einfo "You must restart $web to take effect."
		einfo "if still not effect, please remove compreg.dat in ~/<$web working directory> ."
	fi
}

pkg_postrm()
{
	resetplugin
}
