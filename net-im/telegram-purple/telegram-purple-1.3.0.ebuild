# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit versionator

MY_PV=$(get_version_component_range 1-3)

DESCRIPTION="Libpurple (Pidgin) plugin for using a Telegram account"
HOMEPAGE="https://github.com/majn/${PN}"
SRC_URI="https://github.com/majn/telegram-purple/releases/download/v1.3.0/telegram-purple_${PV}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+libwebp"

DEPEND="net-im/pidgin
		dev-libs/openssl
		sys-libs/glibc
		libwebp? ( media-libs/libwebp )
		"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_configure(){
	sed "s/-Werror//g" -i tgl/Makefile.in Makefile.in
	econf $(use_enable libwebp) || die "econf failed"
}

src_install(){
	emake DESTDIR="${D}" install || die
}
