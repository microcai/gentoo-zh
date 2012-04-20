# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools eutils

DESCRIPTION="GNOME-Shell GJS Plugin for IBus"
HOMEPAGE="https://github.com/fujiwarat/ibus-gjs"
SRC_URI="https://launchpad.net/~mengzhuo1203/+archive/ibus-gjs/+files/ibus-gjs_3+ubuntu04.orig.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=app-i18n/ibus-1.3.99
	>=gnome-base/gnome-shell-3.3"
DEPEND="${RDEPEND}
	>=dev-libs/gjs-1.32.0
	>=dev-util/intltool-0.50.0"

src_unpack() {
	mkdir "${WORKDIR}/${PF}" && cd "${WORKDIR}/${PF}"
	unpack "${A}"
}

src_prepare() {
	intltoolize --copy --force || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	econf $(use_enable debug maintainer-mode)
}
