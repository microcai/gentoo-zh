# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit flag-o-matic eutils multilib autotools googlecode

DESCRIPTION="PCMan is an easy-to-use telnet client mainly targets BBS users formerly writen by gtk2"
HOMEPAGE="http://pcmanx-gtk2.googlecode.com"
SRC_URI="http://pcmanx-gtk2.googlecode.com/files/${P}.tar.xz"

KEYWORDS="amd64 ppc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="+libnotify +proxy iplookup +wget"

# FIXME:
# pcmanx-gtk2 needs xulrunner
COMMON_DEPEND="
	libnotify? ( x11-libs/libnotify )
	x11-libs/libXft
	>=x11-libs/gtk+-2.4
"

RDEPEND="
${COMMON_DEPEND}
	wget? ( net-misc/wget )
"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	sys-devel/gettext
"

RESTRICT="mirror"

#src_prepare() {
#	(has_version ">=net-libs/xulrunner-1.9" && use nsplugin ) && \
#		epatch "${FILESDIR}/${PN}-0.3.8-xulrunner.patch"
#}

src_configure() {
	# better move this to pkg_setup phase?
	# this flag crashes CTermData::memset16()
	filter-flags -ftree-vectorize

	econf $(use_enable proxy) \
		$(use_enable libnotify) \
		$(use_enable wget)\
		$(use_enable iplookup)
}

#src_install(){
#	emake DESTDIR="${D}" install || die "emake failed"
#	if use nsplugin
#	then
#		insinto /usr/$(get_libdir)/nsbrowser/plugins
#		doins plugin/src/pcmanx-plugin.so || die "failed to install firefox plugin"
#	fi
#}
