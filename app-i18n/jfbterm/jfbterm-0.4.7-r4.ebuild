# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit flag-o-matic eutils autotools

DESCRIPTION="The J Framebuffer Terminal/Multilingual Enhancement with UTF-8 support"
HOMEPAGE="http://jfbterm.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/13501/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug ucimf"

DEPEND="ucimf? ( app-i18n/libucimf )"
RDEPEND="media-fonts/unifont
media-fonts/font-misc-misc
ucimf? ( app-i18n/libucimf )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-sigchld-debian.patch"
	epatch "${FILESDIR}/${P}-no-kernel-headers.patch"
	epatch "${FILESDIR}/${P}-ucimf.patch"

	eautoreconf

	sed -i -e 's/a18/8x16/' \
		-e 's:/usr/X11R6/lib/X11/fonts:/usr/share/fonts:' \
		-e 's:/usr/share/fonts/misc/unifont:/usr/share/fonts/unifont/unifont:' \
		jfbterm.conf.sample
}

src_compile() {
	append-ldflags $(bindnow-flags)

	econf \
		$(use_enable debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /etc /usr/share/fonts/jfbterm
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	mv "${D}"/etc/jfbterm.conf{.sample,}

	doman jfbterm.1 jfbterm.conf.5

	dodoc AUTHORS ChangeLog INSTALL* NEWS README*
	dodoc jfbterm.conf.sample*
}
