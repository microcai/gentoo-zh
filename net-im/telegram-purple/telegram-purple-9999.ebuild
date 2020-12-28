# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3

DESCRIPTION="Libpurple (Pidgin) plugin for using a Telegram account"
HOMEPAGE="https://github.com/majn/${PN}"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+libwebp"

DEPEND="net-im/pidgin
		dev-libs/openssl
		sys-libs/glibc
		libwebp? ( media-libs/libwebp )
		"
RDEPEND="${DEPEND}"

src_compile(){
	econf $(use_enable libwebp) || die "econf failed"
	emake || die "emake failed"
}

src_install(){
	emake DESTDIR="${D}" install
}

pkg_postinst(){
	elog "Note: this package is in an early (pre-alpha) stage, so if you"
	elog "want to view changes, install this package often."
	elog "More information is available in ${HOMEPAGE}"
}
