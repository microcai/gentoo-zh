# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools eutils

DESCRIPTION="preload is an adaptive readahead daemon."
HOMEPAGE="http://preload.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}.patch"
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf \
		--localstatedir=/var || die
	emake -j1 || die
}


src_install() {
	dosbin src/preload
	newinitd "${FILESDIR}/init.d-preload" preload
	newconfd "${FILESDIR}/conf.d-preload" preload
	insinto /etc
	doins src/preload.conf
	doman src/preload.8
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO

	insinto /var/lib/preload
	doins preload.state

	insinto /var/log
	doins preload.log
}

