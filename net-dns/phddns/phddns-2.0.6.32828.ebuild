# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

inherit eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Phddns"
HOMEPAGE="http://hsk.oray.com/"
SRC_URI="http://developer.oray.com/download/Peanuthull%20dynamic%20DNS%20SDK.rar -> ${P}.rar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86 ~arm ~hppa ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"

DOCS="AUTHORS"

DEPEND="app-arch/unrar"

src_prepare() {
        chmod a+x configure
}

src_configure() {
        econf \
        --prefix=/usr
}

src_install() {
        newinitd "${FILESDIR}/phddns.init.d" phddns
        exeinto /usr/bin
        doexe src/phddns
} 

pkg_postinst() {
    elog "You will need to run phddns once to config your Oray account!!"
}
