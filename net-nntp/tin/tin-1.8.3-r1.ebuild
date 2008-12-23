# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/tin/tin-1.8.3.ebuild,v 1.1 2007/02/11 13:47:49 swegener Exp $

inherit versionator eutils

DESCRIPTION="A threaded NNTP and spool based UseNet newsreader"
HOMEPAGE="http://www.tin.org/"
SRC_URI="ftp://ftp.tin.org/pub/news/clients/tin/v$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ia64 ~ppc-macos sparc x86"
IUSE="crypt debug idn ipv6 nls unicode zh_TW"

DEPEND="sys-libs/ncurses
	dev-libs/libpcre
	dev-libs/uulib
	idn? ( net-dns/libidn )
	unicode? ( dev-libs/icu )
	nls? ( sys-devel/gettext )
	crypt? ( app-crypt/gnupg )"
RDEPEND="${DEPEND}
	net-misc/urlview"

pkg_setup() {
	if use unicode && ! built_with_use sys-libs/ncurses unicode
	then
		die "For unicode support you need sys-libs/ncurses compiled with unicode support!"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/1.8.2-various.patch
	#add patch for zh_TW
	if use zh_TW
	then
		epatch "${FILESDIR}"/patch-attrib.c
		epatch "${FILESDIR}"/patch-cook.c
		epatch "${FILESDIR}"/patch-init.c
		epatch "${FILESDIR}"/patch-mail.c
		epatch "${FILESDIR}"/patch-tin_defaults
	fi
}

src_compile() {
	local screen="termcap"
	econf \
		--with-pcre=/usr \
		--enable-nntp-only \
		--disable-locale \
		--enable-prototypes \
		--disable-echo \
		--disable-mime-strict-charset \
		--with-coffee  \
		--enable-fascist-newsadmin \
		--with-screen=${screen} \
		--with-nntp-default-server="${TIN_DEFAULT_SERVER:-${NNTPSERVER:-news.gmane.org}}" \
		$(use_enable ipv6) \
		$(use_enable debug) \
		$(use_enable crypt pgp-gpg) \
		$(use_enable nls) \
		|| die "econf failed"
	emake build || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc doc/{CHANGES{,.old},CREDITS,TODO,WHATSNEW,*.sample,*.txt} || die "dodoc failed"
	insinto /etc/tin
	doins "${FILESDIR}"/tinrc 
	doins "${FILESDIR}"/tin.defaults ||die "doins failed"
}
