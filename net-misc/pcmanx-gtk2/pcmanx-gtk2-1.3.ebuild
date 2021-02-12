# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit autotools eutils flag-o-matic multilib

DESCRIPTION="PCMan is an easy-to-use telnet client mainly targets BBS users formerly writen by gtk2"
HOMEPAGE="https://github.com/pcman-bbs/pcmanx"
SRC_URI="https://github.com/pcman-bbs/pcmanx/releases/download/${PV}/${P}.tar.xz"

KEYWORDS="amd64 ppc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="+libnotify +proxy iplookup +wget"
RESTRICT="mirror"

COMMON_DEPEND="
	libnotify? ( x11-libs/libnotify )
	x11-libs/libXft
	>=x11-libs/gtk+-2.4
"

RDEPEND="
	${COMMON_DEPEND}
	wget? ( net-misc/wget )
"

DEPEND="
	${COMMON_DEPEND}
	dev-util/intltool
	sys-devel/gettext
"

src_prepare() {
	# this flag crashes CTermData::memset16()
	filter-flags -ftree-vectorize
	eapply_user
}

src_configure() {
	econf $(use_enable proxy) \
		$(use_enable libnotify) \
		$(use_enable wget)\
		$(use_enable iplookup)
}
