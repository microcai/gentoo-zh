# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib

DESCRIPTION="Compatibility functions for the log e* functions of OpenRC"
HOMEPAGE="http://xochitl.matem.unam.mx/~canek/gentoo-systemd-only/index.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-shells/bash"

S="${WORKDIR}"

src_install() {
	insinto /usr/$(get_libdir)/misc
	doins "${FILESDIR}/${PN}.sh"
}
