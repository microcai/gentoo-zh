# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="A truely minimal markdown editor."
HOMEPAGE="https://typora.io"
SRC_URI="https://download.typora.io/linux/typora_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="typora"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror splitdebug"

RDEPEND="
	x11-libs/libXScrnSaver
	net-print/cups"

QA_PREBUILT="*"

src_unpack() {
	unpack_deb typora_${PV}_amd64.deb
}

src_install() {
	mv "${S}/usr" "${D}" || die

	pushd "${D}/usr/share/doc" > /dev/null || die
	mv ${PN} ${P} || die
	popd > /dev/null || die
}
