# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit git-r3 eutils

DESCRIPTION="Enables USB charging for Apple devices."
HOMEPAGE="https://github.com/mkorenkov/ipad_charge"
EGIT_REPO_URI="https://github.com/mkorenkov/ipad_charge.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libusb:1"
RDEPEND="${DEPEND}"

S=${WORKDIR}/ipad_charge

src_prepare(){
	#sed -i 's|\/usr|\$\{DESTDIR\}\/usr|g' Makefile
	#sed -i 's|\/etc|\$\{DESTDIR\}\/etc|g' Makefile
	epatch ${FILESDIR}/${PN}-9999-makefile.patch
}