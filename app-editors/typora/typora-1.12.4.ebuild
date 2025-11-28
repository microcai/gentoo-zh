# Copyright 1999-2025 Gentoo Authors
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
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	net-print/cups
	x11-libs/libXScrnSaver
"

QA_PREBUILT="*"

src_install() {
	mv "${S}/usr" "${D}" || die

	pushd "${D}/usr/share/doc" > /dev/null || die
	mv ${PN} ${P} || die
	popd > /dev/null || die
}
