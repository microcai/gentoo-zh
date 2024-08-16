# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="print the IP addresses in a range"
HOMEPAGE="http://devel.ringlet.net/sysutils/prips/"
SRC_URI="http://devel.ringlet.net/files/sys/prips/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	emake install DESTDIR="${D}" \
		PREFIX="${EPREFIX}"/usr \
		MANDIR="${EPREFIX}"/usr/share/man/man \
		DOCSDIR="${EPREFIX}"/usr/share/doc/${P}
}
