# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils flag-o-matic systemd

DESCRIPTION="A tool for securing communications between a client and a DNS resolver"
HOMEPAGE="http://www.opendns.com/technology/dnscrypt/"
SRC_URI="http://download.dnscrypt.org/${PN}/old/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_setup() {
	enewgroup dnscrypt
	enewuser dnscrypt -1 -1 /var/empty dnscrypt
}

src_configure() {
	if [[ ! -e configure ]] ; then
		./autogen.sh || die "autogen failed"
	fi
	append-ldflags -Wl,-z,noexecstack || die
	econf --enable-nonblocking-random || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die "newinitd failed"
	newconfd "${FILESDIR}/${PN}.confd" ${PN} || die "newconfd failed"

	systemd_dounit "${FILESDIR}"/${PN}.service

	dodoc {AUTHORS,COPYING,INSTALL,NEWS,README,README.markdown,TECHNOTES,THANKS} || die "dodoc failed"
}
