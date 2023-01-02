# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker

DESCRIPTION="A truely minimal markdown editor."
HOMEPAGE="https://typora.io"
SRC_URI="https://download.typora.io/linux/typora_${PV}_amd64.deb"

LICENSE="typora"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror splitdebug"

DEPEND=""
RDEPEND="
	x11-libs/libXScrnSaver
	net-print/cups
	${DEPEND}"
BDEPEND=""

QA_PREBUILT="*"

src_unpack() {
	unpack_deb typora_${PV}_amd64.deb
	S="${WORKDIR}"
}

src_install() {
	mv "${S}/usr" "${D}"

	pushd "${D}/usr/share/doc" > /dev/null || die
	mv ${PN} ${P}
	popd > /dev/null || die
}

pkg_postinst() {
	update-desktop-database
}
