# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools eutils

DESCRIPTION="GNOME-Shell GJS Plugin for IBus"
HOMEPAGE="https://github.com/fujiwarat/ibus-gjs"
SRC_URI="https://github.com/fujiwarat/ibus-gjs/tarball/${PV%_p*}.${PV#*_p}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=app-i18n/ibus-1.3.99
	>=gnome-base/gnome-shell-3.2"
DEPEND="${RDEPEND}
	>=dev-libs/gjs-1.30.0
	>=dev-util/intltool-0.50.0"

src_unpack() {
	tar -zxf "${DISTDIR}"/"${PV%_p*}.${PV#*_p}" -C "${WORKDIR}" && \
		mv "${WORKDIR}"/* "${WORKDIR}"/${PF} || die "unpacking source failed"
}

src_prepare() {
	[[ ! -d "${S}/m4" ]] && mkdir "${S}/m4"
	intltoolize --copy --force || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	econf $(use_enable debug maintainer-mode)
}
