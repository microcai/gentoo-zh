# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Phddns"
HOMEPAGE="http://hsk.oray.com/"
SRC_URI="http://developer.oray.com/download/Peanuthull%20dynamic%20DNS%20SDK.rar -> ${P}.rar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DOCS="AUTHORS"

DEPEND="app-arch/unrar"

src_prepare() {
	chmod a+x configure
	default
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
