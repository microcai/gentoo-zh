# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

MY_PN="${PN%-bin}"
DESCRIPTION="An open-source cross-platform alternative to AirDrop"
HOMEPAGE="https://localsend.org"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/v${PV}/${MY_PN}-${PV}-linux-x86-64.tar.gz"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="bindist"

QA_PREBUILT="opt/localsend/lib/*"

DEPEND="
	dev-libs/libayatana-appindicator
	x11-misc/xdg-user-dirs
"

src_install() {
	exeinto /opt/localsend
	doexe localsend_app

	cp -R "${S}/lib/" "${D}/opt/localsend" || die "install libraries failed"
	cp -R "${S}/data/" "${D}/opt/localsend" || die "install neccessary assets failed"

	newicon "${S}"/data/flutter_assets/assets/img/logo.ico localsend.ico

	newmenu "${FILESDIR}"/localsend.desktop localsend.desktop

	dodir /opt/bin
	dosym ../localsend/localsend_app /opt/bin/localsend
}
