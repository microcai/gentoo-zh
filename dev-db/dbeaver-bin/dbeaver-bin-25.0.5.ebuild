# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop wrapper xdg

DESCRIPTION="Free universal database tool (community edition)."
HOMEPAGE="https://dbeaver.io/"
MY_PN="${PN%-bin*}"
SRC_URI="https://dbeaver.io/files/${PV}/${MY_PN}-ce-${PV}-linux.gtk.x86_64-nojdk.tar.gz -> ${P}-amd64.tar.gz"
S="${WORKDIR}/${MY_PN}"

LICENSE="Apache-2.0 EPL-1.0 BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jdk-17"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -e "s/^Icon=.*/Icon=${MY_PN}/" \
		-e 's:/usr/share/dbeaver:/opt/dbeaver:g' \
		-e '/^WMCLASS.*/d' \
		-e "s:^Exec=.*:Exec=${EPREFIX}/usr/bin/${MY_PN}:" \
		-i "${MY_PN}-ce.desktop" || die
	default
}

src_install() {
	doicon -s 128 "${MY_PN}.png"
	newicon icon.xpm "${MY_PN}.xpm"
	domenu "${MY_PN}-ce.desktop"
	einstalldocs
	rm "${MY_PN}-ce.desktop" "${MY_PN}.png" icon.xpm readme.txt || die
	insinto "/opt/${MY_PN}-ce"
	doins -r *
	fperms 0755 "/opt/${MY_PN}-ce/${MY_PN}"
	make_wrapper "${MY_PN}" "/opt/${MY_PN}-ce/${MY_PN}" "/opt/${MY_PN}-ce"
}
